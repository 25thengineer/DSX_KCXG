function W = spin_perturb(X,W,Ea,T)
% W = spin_perturb(X,W,Ea,T)
% Method for spinglass example supplied with SA Tools.
% See http://www.frostconcepts.com/software for information on SA Tools.
%
%   W = spin_perturb(X,W,Ea,T) ;
%
%   X = {n, J}
%       n = size of coupling matrix, n = width*depth*height
%       J = restricted range coupling matrix
%   W = vector of +1, -1 spins of length n
%   Ea = (not used) average energy at current temperature.
%   T = (not used) current temperature
%
%   Changes sign of random element of W
%
n = X{1} ;
i = 1 + floor(n*rand) ;
W(i) = -W(i) ;
