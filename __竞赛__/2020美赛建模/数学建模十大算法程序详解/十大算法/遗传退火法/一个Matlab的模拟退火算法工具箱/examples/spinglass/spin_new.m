function W = spin_new(X)
% W = spin_new(X)
% Method for spinglass example supplied with SA Tools.
% See http://www.frostconcepts.com/software for information on SA Tools.
%
%   W = spin_new(X) ;
%
%   X = {n, J}
%       n = size of coupling matrix, n = width*depth*height
%       J = normalized restricted range coupling matrix
%   W = new vector of random +1, -1 spins of length n
%
for i=1:X{1}
    if rand < 0.5
        W(i) = -1 ;
    else
        W(i) = +1 ;
    end
end
