function E = spin_cost(X,W)
% E = spin_cost(X,W)
% Method for spinglass example supplied with SA Tools.
% See http://www.frostconcepts.com/software for information on SA Tools.
%
%   E = spin_cost(X,W) ;
%
%   X = {n, J}
%       n = size of coupling matrix, n = width*depth*height
%       J = restricted range coupling matrix
%   W = vector of +1, -1 spins of length n
%   E = energy corresponding to W
%
%       E  is  sum of  J(i,j)*W(i)*W(j)
%
n = X{1} ;
J = X{2} ;
E = 0 ;
for i=1:(n-1)
    for j=i+1:n
        E = E + (J(i,j)*W(i)*W(j)) ;
    end
end
