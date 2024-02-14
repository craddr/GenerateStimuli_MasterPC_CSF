function run1DAQ(animalID, Pstate)
%% written by RC 2024


%%get the expID from the animalID
expID=dat.newExp(animalID);
%set the DAQ as timeline
DAQs="timeline"; 
%%load the UDP connection ports to use from file made earlier
%%%change UDPPartners as appropriate so ps is is the ip address of the PC generating the visual stimuli.
load("C://code//UDPPartners.mat");
%%open a udp port for communication
udpComms=udpport("LocalPort", UDPPartners.ps.serverSendPort, "Timeout", 4000); 
%%check the connection
writeline(udpComms, "TESTING", UDPPartners.ps.address, UDPPartners.ps.serverListenPort); 
%%wait for response then check for "OK"
pause(0.5);
udpData=readline(udpComms);
%%flush the udpport ready for more inputs
flush(udpComms);
if ~isempty(udpData)
    if strcmp(udpData, "OK")
        disp("testing connection with VS PC server 'timeline' successful");
    else 
        disp("unexpected response from VS PC server 'timeline', test failed");
        return; 
        
    end 
else 
    disp("testing connection with VS PC server 'timeline' failed"); 
    return;
end


%% send the expID to the VS PC, then wait for confirmation
writeline(udpComms, expID, UDPPartners.ps.address, UDPPartners.ps.serverListenPort); 
pause(0.5);
udpData=readline(udpComms);
flush(udpComms);
if ~isempty(udpData)
    if strcmp(udpData, "expID received")
        disp("expID received"); 
    else 
        disp("comm failure- expID"); 
        return;
    end 
else 
    disp("comm failure expID"); 
    return; 
end

%%compress the stimulus parameters 

% convert condition parameters to numbers (from chars)
for row = 1:size(Pstate.stims,1)
    for col = 1:size(Pstate.stims,2)
        convertedParam = str2num(Pstate.stims{row,col});
        if isempty(convertedParam)
            stims(row,col)=1;
        else
        stims(row,col) = str2num(Pstate.stims{row,col});
        end
    end
end


Pstate.stims=stims;

%%serialise the stimlus parameters to make them faster and easier to send
%%over udp (Christian Kothe (2023). Fast serialize/deserialize
%%(https://www.mathworks.com/matlabcentral/fileexchange/34564-fast-serialize-deserialize), MATLAB Central File Exchange. Retrieved February 20, 2023._
% 
Pstate= funcs.hlp_serialize(Pstate);

write(udpComms, Pstate, UDPPartners.ps.address, UDPPartners.ps.serverListenPort);

%%and from here on out, the bus mostly drives itself.

udpData=readline(udpComms); 
flush(udpComms);
if ~isempty(udpData)
    if strcmp(udpData, "ExperimentComplete")
        disp("ExpSuccess!"); 
        expLog.expSummary=inputdlg("Experiment Comments?"); 
        if ~exist(fullfile(data.animalRootRemote(data.expID2AnimalID(expID)),'log'),'dir')
            mkdir(fullfile(data.animalRootRemote(data.expID2AnimalID(expID)),'log'))
                
        end
                
        save(fullfile(data.animalRootRemote(data.expID2AnimalID(expID)),'log',[expID,'.mat']),'expLog')
                
        return;
    end
end
end











       


