function W = route_new(X)
% W = route_new(X)
% Method for tsp example supplied with SA Tools.
% See http://www.frostconcepts.com/software for information on SA Tools.
%
%   W = route_new(X) ;
%
%   X = {N, D}
%       N = # of cities.
%       D = distance matrix. D(i,j) = distance from city i to j.
%   W = new route, a permutation of the indicies 1:N
%
N = X{1} ;
for i=1:N
    A(i,1) = rand ;
    A(i,2) = i ;
end
B = sortrows(A) ;
W = B(:,2) ;
