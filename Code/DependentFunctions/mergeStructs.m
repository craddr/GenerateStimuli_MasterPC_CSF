function s = mergeStructs(varargin)

%%% written by CB 2013
%MERGESTRUCTS Concatenates different structures into one structure array
%   s = MERGESTRUCTS(struct1, struct2,...)
%
% Part of Burgbox

% 2013-11 CB created

if nargin ~= 1
  % called with multiple arguments, so call instead with those args in one
  % cell array
  s = mergeStructs(varargin);
else
  cellOfStructs = varargin{1};
  fields = cellfun(@fieldnames, cellOfStructs, 'uni', false);
  fields = cat(1, fields{:});
  data = cellfun(@struct2cell, cellOfStructs, 'uni', false);
  data = cat(1, data{:});
  [uniqueFields, iFields] = unique(fields, 'stable');
  mergedData = data(iFields);
  s = cell2struct(mergedData, uniqueFields, 1);
end

end

