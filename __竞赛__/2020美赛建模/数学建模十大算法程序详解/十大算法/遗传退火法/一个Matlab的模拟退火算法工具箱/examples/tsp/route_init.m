function X = route_init(N)
% X = route_init(N)
% Method for tsp example supplied with SA Tools.
% See http://www.frostconcepts.com/software for information on SA Tools.
%
%   X = route_init(N) ;
%
%   N = # of cities.  must be > 3.
%   X = {N, D}
%       N = # of cities.
%       D = distance matrix. D(i,j) = distance from city i to j.
%
%   Generates a distance matrix for N cities in toy TSP problem.
%   In a real problem, the distances are problem-specific and might be read from a file.
%   Values in this matrix are skewed towards the max and min.
%   Each N will always generate the same distance matrix.
%
Nin = N ;
N = floor(Nin) ;
if N < 4
    error(sprintf('N must be > 3.  was: %g', Nin)) ; 
end
%
enatural = exp(1) ;
MaxDistance = 420 ;
S = rand('state') ;
rand('state',731511) ;
for i=1:N
    for j=i:N
        x = (2*pi)*(1 - (2*rand)) ;
        D(i,j) = ceil(MaxDistance*(.5+(.5*tanh(x/enatural)))) ;
        D(j,i) = D(i,j) ;
    end
end
rand('state',S) ;
%
X = {N D} ;
