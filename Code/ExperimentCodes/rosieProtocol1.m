function rosieProtocol1(animalID, DAQ_number, pfile)

%%% written by RC 2024
%%%for testing code
if DAQ_number==1

    %DAQs=["timeline"]; 
    load(fullfile("C:\Code\pFiles", pfile));

    run1DAQ(animalID, Pstate);

    if exist('udpComms', 'var')==1
        clear udpComms; 
    end 

    
elseif DAQ_numlab1
    ber==2

%%for running 

    %DAQs=["timeline", "2P"];

    load(fullfile("C:\Code\pFiles", pfile));


    run2DAQ(animalID, Pstate);
else 
    disp("inappropriate input for DAQ_number"); 
    return; 
end 




