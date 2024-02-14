function b = emptyElems(C)
%EMPTYELEMS Which elements of a cell array are empty
%   b = EMPTYELEMS(C) returns a logical array 'b' the same shape as 'C' with
%   each value true when the corresponding element is empty, false
%   otherwise.

%%%% written by Adam Ranson 2014

b = cellfun(@(e) isempty(e), C);

end

