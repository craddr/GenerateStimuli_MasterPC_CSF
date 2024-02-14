function [dataDir] = remote(expID,type)
%%%% written by Adam Ranson 2014, ammended by RC 2024.
% specify default repos for new data copied from server
defaultRepos = 3;
% specify remote roots
% first one is the default for making new data directories
%%%% change all instances of '\\ar-lab-nas4\SHARE\DATA\Remote_Repository' to be the path for your remote repository 
if strcmp(hostname,'ar-office-1')
    remoteRepositoryRoot = {'\\ar-lab-nas1\SHARE\DATA\Remote_Repository','\\ar-lab-nas3\SHARE\DATA\Remote_Repository','\\ar-lab-nas4\SHARE\DATA\Remote_Repository'};
elseif strcmp(hostname,'ar-lab-vs')
    remoteRepositoryRoot = {'\\ar-lab-nas1\SHARE\DATA\Remote_Repository','\\ar-lab-nas3\SHARE\DATA\Remote_Repository','\\ar-lab-nas4\SHARE\DATA\Remote_Repository'};
elseif strcmp(hostname,'ar-lab-2p')
    remoteRepositoryRoot = {'\\ar-lab-nas1\SHARE\DATA\Remote_Repository','\\ar-lab-nas3\SHARE\DATA\Remote_Repository','\\ar-lab-nas4\SHARE\DATA\Remote_Repository'};
elseif strcmp(hostname,'ar-lab-eye')
    remoteRepositoryRoot = {'\\ar-lab-nas1\SHARE\DATA\Remote_Repository','\\ar-lab-nas3\SHARE\DATA\Remote_Repository','\\ar-lab-nas4\SHARE\DATA\Remote_Repository'};
elseif strcmp(hostname,'ar-lab-vs2')
    remoteRepositoryRoot = {'\\ar-lab-nas1\SHARE\DATA\Remote_Repository','\\ar-lab-nas3\SHARE\DATA\Remote_Repository','\\ar-lab-nas4\SHARE\DATA\Remote_Repository'};
elseif strcmp(hostname,'ar-lab-vs3')
    remoteRepositoryRoot = {'\\ar-lab-nas1\SHARE\DATA\Remote_Repository','\\ar-lab-nas3\SHARE\DATA\Remote_Repository','\\ar-lab-nas4\SHARE\DATA\Remote_Repository'};
elseif strcmp(hostname,'ar-lab-vs4')
    remoteRepositoryRoot = {'\\ar-lab-nas1\SHARE\DATA\Remote_Repository','\\ar-lab-nas3\SHARE\DATA\Remote_Repository','\\ar-lab-nas4\SHARE\DATA\Remote_Repository'};
elseif strcmp(hostname,'ar-lab-bs1')
    remoteRepositoryRoot = {'\\ar-lab-nas1\SHARE\DATA\Remote_Repository','\\ar-lab-nas3\SHARE\DATA\Remote_Repository','\\ar-lab-nas4\SHARE\DATA\Remote_Repository'};
elseif strcmp(hostname,'ar-lab-ellie')
    remoteRepositoryRoot = {'\\ar-lab-nas1\SHARE\DATA\Remote_Repository','\\ar-lab-nas3\SHARE\DATA\Remote_Repository','\\ar-lab-nas4\SHARE\DATA\Remote_Repository'};
elseif strcmp(hostname,'ar-lab-rich')
    remoteRepositoryRoot = {'\\ar-lab-nas1\SHARE\DATA\Remote_Repository','\\ar-lab-nas3\SHARE\DATA\Remote_Repository','\\ar-lab-nas4\SHARE\DATA\Remote_Repository'};
elseif strcmp(hostname,'apbiosci')
    remoteRepositoryRoot = {'\\ar-lab-nas1\SHARE\DATA\Remote_Repository','\\ar-lab-nas3\SHARE\DATA\Remote_Repository','\\ar-lab-nas4\SHARE\DATA\Remote_Repository'};
else
    msgbox('This computer doesn''t have a remote repository registered in data.remote');
    return;
end

if exist('expID','var')
    if strcmp(expID,'animals')
        % special case to list animals
        dataDir = [];
        if ~exist('type')
            type = '*';
        end
        for iRepos = 1:length(remoteRepositoryRoot)
            folders = get_directory_names(fullfile(remoteRepositoryRoot{iRepos},type))';
            dataDir = [dataDir,folders];
        end
        dataDir = sort(dataDir);
        return
    end
end

if exist('expID','var')
    if strcmp(expID,'remote')
        dataDir.remoteRepositoryRoot = remoteRepositoryRoot;
        dataDir.defaultRepos = defaultRepos;
        return
    end
end

if exist('type','var')
    % full path to specific item of data is needed
    animalID = data.expID2AnimalID(expID);
    dataDir = fullfile(data.animalRootRemote(animalID),expID,[expID,'_',type]);
elseif exist('expID','var')
    % full path to root of data directory for this experiment is needed
    % 1) check it's the path to the animal root or experiment root that's
    % needed
    if length(expID)==7
        % it's the path to animal root needed
        % try to locate if animal directory is present in any of the remote
        % data dirs:
        animalID = expID;
        dataDir = data.animalRootRemote(animalID);
    else
        % try to locate if experiment directory is present in any of the remote
        animalID = data.expID2AnimalID(expID);
        dataDir = fullfile(data.animalRootRemote(animalID),expID);
    end
else
    % path to root of data directory for this computer is needed
    % This is probably the function being used in error as no animal or
    % experiment ID is being submitted. 
    disp('###########################################');
    disp('#######Please update ######################');
    disp('#######code to submit animalID ############');
    disp('#######or expID - #########################');
    disp('########function updated###################');
    disp('####to handle multiple drives##############');
	disp('###########################################');
	disp('#If not fixed: REPORT TO ADAM/ROSIE!!!!####');
    error('Please update code to submit animalID or expID - function updated to handle multiple drives');
    %dataDir = remoteRepositoryRoot{defaultRepos};
end

end

function [ dirList ] = get_directory_names( dir_name )

    %get_directory_names; this function outputs a cell with directory names (as
    %strings), given a certain dir name (string)
    %from: http://stackoverflow.com/questions/8748976/list-the-subfolders-
    %in-a-folder-matlab-only-subfolders-not-files

    dd = dir(dir_name);
    isub = [dd(:).isdir]; %# returns logical vector
    dirList = {dd(isub).name}';
    dirList(ismember(dirList,{'.','..'})) = [];

end
