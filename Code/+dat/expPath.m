function [p, expRef] = expPath(varargin)

%%%% written by CB 2013
%DAT.EXPPATH Folder paths for files pertaining to designated experiment
%   [P, REF] = DAT.EXPPATH(ref, reposname, [reposlocation]) returns paths
%   for the experiment 'ref' at a particular repository 'reposname'.
%   Optionally specify 'reposlocation' to specify a specific repository's
%   location.
%
%   [P, REF] = DAT.EXPPATH(subject, date, seq, reposname, [reposlocation])
%   sames as the above, but returns paths for an experiment with a
%   specified 'subject', on a particular 'date', and numbered 'seq'.
%
% e.g. to get the paths for the 'expInfo' repository, for the first
% experiment of the day for 'SUBJECTA':
% 
% paths = DAT.EXPPATH('SUBJECTA', now, 1, 'expInfo');
%
% Part of Rigbox

% 2013-03 CB created

% take care of handling with/without 'reposlocation' arg
if nargin == 2 || nargin == 4
  reposArgs = varargin(end);
  varargin = varargin(1:end - 1);
else
  reposArgs = varargin((end - 1):end);
  varargin = varargin(1:end - 2);
end

reposArgs = mapToCell(@ensureCell, reposArgs); % wrap non-cell reposArgs in a cell
% get the paths for each repos arg
reposPaths = mapToCell(@dat.reposPath, reposArgs{:});

% tabulate the args to get complete rows
[varargin{1:end}, singleArgs] = tabulateArgs(varargin{:});

reposPaths = repmat(reposPaths, size(varargin{1}));

if nargin == 2 || nargin == 3
  expRef = varargin{1};
  [subjectRef, expDate, expSequence] = dat.parseExpRef(expRef);
elseif nargin == 4 || nargin == 5
  [subjectRef, expDate, expSequence] = varargin{:};
  expRef = dat.constructExpRef(subjectRef, expDate, expSequence);
else
  error('Incorrect number of arguments');
end

pathfun = @(p, sub, dat, seq) fullfile(p, sub, datestr(dat, 'yyyy-mm-dd'), sprintf('%i', seq));

p = mapToCell(pathfun, reposPaths, subjectRef, expDate, expSequence);
if singleArgs
  % we were passed non-cell arguments so make sure we dont return cells
  p = p{1};
  expRef = expRef{1};
end

end