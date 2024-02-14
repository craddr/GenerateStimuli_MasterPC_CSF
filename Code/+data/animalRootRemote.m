function rootDir = animalRootRemote(animalID,sub)

%%%% written by Adam Ranson 2014
% returns remote root directory of an animal with optional append of
% subdirectory
if ~exist('sub','var')
    sub = [];
end
% get possible remote directories
dataDir = data.remote('remote');
% check if any of the remote repositories contain the animal folder
for iRepos = 1:length(dataDir.remoteRepositoryRoot)
    % check if animal folder exists
    if exist(fullfile(dataDir.remoteRepositoryRoot{iRepos},animalID),'dir')
        dirPresent(iRepos)=1;
    else
        dirPresent(iRepos)=0;
    end
end
if sum(dirPresent)>1
    % then there is an animal dir on more than one remote repos with the
    % same name. this is not permitted
    error('There is an animal dir on more than one remote repos with the same name. Correct this.');
elseif sum(dirPresent)==1
    % there is an existing animal folder
    reposPath = dataDir.remoteRepositoryRoot{dirPresent==1};
    rootDir = fullfile(reposPath,animalID,sub);
else
    % use default path the hypothetical animal folder on default server
    reposPath = dataDir.remoteRepositoryRoot{dataDir.defaultRepos};
    rootDir = fullfile(reposPath,animalID,sub);
end
end