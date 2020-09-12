function W = bipart_perturb(X,W,Ea,T)
% W = bipart_perturb(X,W,Ea,T)
% Method for graphbipart example supplied with SA Tools.
% See http://www.frostconcepts.com/software for information on SA Tools.
%
%   W = bipart_perturb(X,W,Ea,T) ;
%
%   X = {N, A}
%       N = # of vertices.
%       A = Adjacency matrix.
%   W = vector of +1, -1 partition of length N
%   Ea = (not used) average energy at current temperature.
%   T = (not used) current temperature
%
%   Flips the sign of a random element of W.
%
n = X{1} ;
i = 1 + floor(n*rand) ;
W(i) = -W(i) ;
