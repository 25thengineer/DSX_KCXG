function W = bipart_new(X)
% W = W = bipart_new(X)
% Method for graphbipart example supplied with SA Tools.
% See http://www.frostconcepts.com/software for information on SA Tools.
%
%   W = bipart_new(X) ;
%
%   X = {N, A}
%       N = # of vertices.
%       A = Adjacency matrix.
%   W = new vector of random +1, -1 partition of length N
%
for i=1:X{1}
    if rand < 0.5
        W(i) = -1 ;
    else
        W(i) = +1 ;
    end
end
