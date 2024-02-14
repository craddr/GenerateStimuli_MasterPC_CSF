function [subjectRef, expDate, expSequence] = parseExpRef(ref)

%%% written by CB 2013
%DATA.PARSEEXPREF Extracts subject, date and seq from an experiment ref
%   [subject, date, seq] = DATA.PARSEEXPREF(ref)
%
%   The pattern for 'ref' should be '{date}_{seq#}_{subject}', with two
%   date formats accepted, either 'yyyy-mm-dd' or 'yyyymmdd'.
%
%   Experiment refs with the former format can be constructed with from
%   subject, date and sequence number with data.constructExpRef.
%
% Part of Rigbox

% 2013-03 CB created

if isempty(ref)
  subjectRef = cell(size(ref));
  expDate = zeros(size(ref));
  expSequence = zeros(size(ref));
elseif iscell(ref)
  % process and return arrays (a cell array for subjectRef)
  parsed = regexp(ref, dat.expRefRegExp, 'names');
  failed = emptyElems(parsed);
  if any(failed)
    error('''%s'' could not be parsed', first(ref(failed)));
  end
  parsed = cell2mat(parsed);
  subjectRef = reshape({parsed.subject}, size(ref));
  expDate = reshape(datenum(...
    cellstr2double({parsed.year}),...
    cellstr2double({parsed.month}),...
    cellstr2double({parsed.day})), size(ref));
  expSequence = reshape(cellstr2double({parsed.seq}), size(ref));
%   fields = textscan(sprintf('%s\n', ref{:}),...
%     '%s %u %s', 'delimiter', '_', 'EndOfLine', '\n');
%   expDate = reshape(datenum(fields{1}, 'yyyy-mm-dd'), size(ref));
%   expSequence = reshape(fields{2}, size(ref));
%   subjectRef = reshape(fields{3}, size(ref));
else
  % process and return a single string for subjectRef
  parsed = regexp(ref, dat.expRefRegExp, 'names');
  subjectRef = parsed.subject;
  expDate = datenum(...
    str2double(parsed.year),...
    str2double(parsed.month),...
    str2double(parsed.day));
  expSequence = cellstr2double(parsed.seq);
%   fields = textscan(sprintf('%s\n', ref),...
%     '%s %u %s', 'delimiter', '_', 'EndOfLine', '\n');
%   expDate = datenum(fields{1}, 'yyyy-mm-dd');
%   expSequence = fields{2};
%   subjectRef = fields{3}{1};
end


end

