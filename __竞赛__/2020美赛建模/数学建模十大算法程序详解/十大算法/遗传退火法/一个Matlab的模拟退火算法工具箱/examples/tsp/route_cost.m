function Ew = route_cost(X,W)
% Ew = route_cost(X,W)
% Method for tsp example supplied with SA Tools.
% See http://www.frostconcepts.com/software for information on SA Tools.
%
%   Ew = route_cost(X,W) ;
%
%   X = {N, D}
%       N = # of cities.
%       D = distance matrix. D(i,j) = distance from city i to j.
%   W = a route, a permutation of the indicies 1:N
%
%   Ew = energy corresponding to W.
%   Computed by summing the distances along the route.
%
N = X{1} ;
D = X{2} ;
Ew = D(W(N),W(1)) ;
for i=1:(N-1)
    Ew = Ew + D(W(i),W(i+1)) ;
end
