function E = bipart_cost(X,W)
% E = bipart_cost(X,W)
% Method for graphbipart example supplied with SA Tools.
% See http://www.frostconcepts.com/software for information on SA Tools.
%
%   E = bipart_cost(X,W) ;
%
%   X = {N, A}
%       N = # of vertices.
%       A = Adjacency matrix.
%   W = vector of +1, -1 partition of length N
%   E = energy corresponding to W
%
N = X{1} ;
A = X{2} ;
%
% count number of edges between partitions
%
B = 0 ;
for i=1:(N-1)
    for j=i+1:N
        B = B + ( A(i,j) * (1 - W(i)*W(j)) ) ;
    end
end
B = 0.5*B ;
%
% Compute the "balance" of the 2 partitions and make it a penalty
% 
S = 0 ;
for i=1:N
    S = S + W(i) ;
end
S = abs(S) ;
%
%
E = B + S ;
