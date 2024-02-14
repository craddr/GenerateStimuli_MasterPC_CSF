function p = paths(rig)

%% written by CB 2013, ammended by RC 2024
%DAT.PATHS Returns struct containing important paths
%   p = DAT.PATHS([RIG])
%
% Part of Rigbox

% 2013-03 CB created

thishost = hostname;

if nargin < 1 || isempty(rig)
  rig = thishost;
end

server1Name = 'C:\\code';
server2Name = 'C:\\code';
server3Name = 'C:\\code';

%% defaults
% path containing rigbox config folders
p.rigbox = fullfile(server1Name, 'code', 'Rigging');
% Repository for local copy of everything generated on this rig
p.localRepository = 'C:\LocalExpData';
% Repository for info about experiments, i.e. stimulus, behavioural,
% Timeline etc
p.expInfoRepository = fullfile(server1Name, 'data', 'expInfo');
% Repository for storing two photon movies
p.twoPhotonRepository = fullfile(server1Name, 'data', '2Photon');
% Repository for storing eye tracking movies
p.eyeTrackingRepository = fullfile(server1Name, 'data', 'EyeCamera');
% Repository for storing behavioural camera
p.behavRepository = fullfile(server1Name, 'data', 'BehavCamera');
% Repository for storing intrinsic signal imaging camera
p.intrinsicRepository = fullfile(server1Name, 'data', 'IntrinsicCamera');
% Repository for storing analysed data including registered data and event
% files.
p.analysisRepository = fullfile(server1Name, 'data', 'Analysis');
% Root of data directory
p.dataRepository = fullfile(server1Name, 'data');

% directory for organisation-wide configuration files
p.globalConfig = fullfile(p.rigbox, 'config');
% directory for rig-specific configuration files
p.rigConfig = fullfile(p.globalConfig, rig);

%% load rig-specific overrides from config file, if any  
customPathsFile = fullfile(p.rigConfig, 'paths.mat');
if file.exists(customPathsFile)
  customPaths = loadVar(customPathsFile, 'paths');
  if isfield(customPaths, 'centralRepository')
    % 'centralRepository' is deprecated, remove field, if any
    customPaths = rmfield(customPaths, 'centralRepository');
  end
  % merge paths structures, with precedence on the loaded custom paths
  p = mergeStructs(customPaths, p);
end


end