function s = expRefRegExp()

%% writen by CB 2014
%DAT.EXPREFREGEXP Regular expression for parsing Rigging experiment refs
%   s = expRefRegExp() returns a regular expression string for parsing
%   Rigging experiment refs into tokens for date fields, sequence number
%   and subject.
%
%   The pattern for 'ref' should be '{date}_{seq#}_{subject}', with two
%   date formats accepted, either 'yyyy-mm-dd' or 'yyyymmdd'.
%
% Part of Rigbox

% 2014-01 CB created

s = '(?<year>^\d\d\d\d)\-?(?<month>\d\d)\-?(?<day>\d\d)\-?_(?<seq>[0-9]+)_(?<subject>\w+)';

end