
function [expRef, expSeq] = newExp(subject, expDate, expParams)

%%% written by CB 2013
%DAT.NEWEXP Create a new unique experiment in the database
%   [ref, seq] = DAT.NEWEXP(subject, expDate, expParams) TODO
%
% Part of Rigbox

% 2013-03 CB created

if nargin < 2
  % use today by default
  expDate = now;
end

if nargin < 3
  % default parameters is empty variable
  expParams = [];
end

if ischar(expDate)
  % if the passed expDate is a string, parse it into a datenum
  expDate = datenum(expDate, 'yyyy-mm-dd');
end

% check the subject exists in the database
if  ~any(strcmp(dat.listSubjects, subject))
    mkdir(fullfile(dat.reposPath('expInfo', 'master'),subject));
    %assert(exists, sprintf('"%" does not exist', subject));
end

% retrieve list of experiments for subject
[~, dateList, seqList] = dat.listExps(subject);

% filter the list by expdate
expDate = floor(expDate);
filterIdx = dateList == expDate;

% find the next sequence number
expSeq = max(seqList(filterIdx)) + 1;
if isempty(expSeq)
  % if none today, max will have returned [], so override this to 1
  expSeq = 1;
end

% expInfo repository is the reference location for which experiments exist
[expPath, expRef] = dat.expPath(subject, expDate, expSeq, 'expInfo');
% ensure nothing went wrong in making a "unique" ref and path to hold
assert(~any(file.exists(expPath)), ...
  sprintf('Something went wrong as experiment folders already exist for "%s".', expRef));

% now make the folder(s) to hold the new experiment
assert(all(cellfun(@(p) mkdir(p), expPath)), 'Creating experiment directories failed');

% now save the experiment parameters variable
superSave(dat.expFilePath(expRef, 'parameters'), struct('parameters', expParams));

end