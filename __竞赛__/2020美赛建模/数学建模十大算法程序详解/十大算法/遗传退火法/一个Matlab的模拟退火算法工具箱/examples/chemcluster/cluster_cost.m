function c = cluster_cost(X,W)
% c = cluster_cost(X,W)
% Method for chemcluster example supplied with SA Tools.
% See http://www.frostconcepts.com/software for information on SA Tools.
%
%   c = cluster_cost(X,W) ;
%
%   X = [N,a,b,g,rho]
%       N = number of molecules
%       a = Lennard-Jones coefficient
%       b = Lennard-Jones coefficient
%       g = compression factor used in perturb
%       rho = (b/a)^(1/6) two-particle 1d solution
%   W = N 3D points.
%   c = total energy of LJ pair potentials
%
N = X(1) ;
a = X(2) ;
b = X(3) ;
c = 0 ;
for j=2:N
    for i=1:(j-1)
        m = norm(W(j,:) - W(i,:)) ;
        f = (-a/(m^6)) + (b/(m^12)) ;
        c = c + f ;
    end
end
