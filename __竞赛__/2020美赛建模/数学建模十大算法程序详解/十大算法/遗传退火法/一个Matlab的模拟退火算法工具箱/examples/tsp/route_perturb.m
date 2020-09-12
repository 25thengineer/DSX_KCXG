function W = route_perturb(X,W,Ea,T)
% W = route_perturb(X,W,Ea,T)
% Method for tsp example supplied with SA Tools.
% See http://www.frostconcepts.com/software for information on SA Tools.
%
%   W = route_perturb(X,W,Ea,T) ;
%
%   X = {N, D}
%       N = # of cities.
%       D = distance matrix. D(i,j) = distance from city i to j.
%   W = a route, a permutation of the indicies 1:N
%   Ea = (not used) current average energy
%   T = (not used) current temperature
%
%   Chooses two cities along route and then reverses path between those points.
%   Circular boundary conditions are used if the 1st city is "past" the second
%       in the route.
%   N must be greater than 3.
%
N = X{1} ;
if N < 4
    error(sprintf('N must be greater than 3.  was: %g', N)) ;
end
%
%
Wold = W ;
%
a = ceil(N*rand) ;
d = 0 ;
while d < 3
    b = ceil(N*rand) ;
    if a < b
        d = b - a ;
    else
        d = (N - a) + b ;
    end
end
L = d - 1 ;
%
for m=1:L
    i = mod(((a + m) - 1),12) + 1 ;
    k = mod(((b - m) - 1),12) + 1 ;
    W(i) = Wold(k) ;
end
