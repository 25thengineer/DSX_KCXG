function W = cluster_new(X)
% W = cluster_new(X)
% Method for chemcluster example supplied with SA Tools.
% See http://www.frostconcepts.com/software for information on SA Tools.
%
%   W = cluster_new(X) ;
%
%   X = [N,a,b,g,rho]
%   N = number of molecules
%   a = Lennard-Jones coefficient
%   b = Lennard-Jones coefficient
%   g = compression factor used in perturb
%   rho = (b/a)^(1/6) two-particle 1d solution
%   W = N 3D points.
%
%   Creates an initial configuration of molecules
%       based on values stored in X (see clusterparams).
%   Calls stillinger3Dpoints(...).
%
N = X(1) ;
rho = X(5) ;
rmax = (sqrt(3)/2)*(N^(1/3))*rho ;
for n=1:N
    q = n / N ;
    theta = q*2*pi ;
    phi = (pi/2) + (q*pi) ;
    r = q*rmax ;
    [W(n,1),W(n,2),W(n,3)] = sph2cart(theta,phi,r) ;
end
[W,o] = stillinger3Dpoints(W,N,rho) ;
