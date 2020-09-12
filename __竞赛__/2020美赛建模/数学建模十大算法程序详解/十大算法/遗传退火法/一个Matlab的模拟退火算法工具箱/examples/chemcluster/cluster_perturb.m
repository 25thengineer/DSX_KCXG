function Wnew = cluster_perturb(X,W,Ea,T)
% Wnew = cluster_perturb(X,W)
% Method for chemcluster example supplied with SA Tools.
% See http://www.frostconcepts.com/software for information on SA Tools.
%
%   Wnew = cluster_perturb(X,W,Ea,T) ;
%
%   X = [N,a,b,g,rho]
%       N = number of molecules
%       a = Lennard-Jones coefficient
%       b = Lennard-Jones coefficient
%       g = compression factor used in perturb
%       rho = (b/a)^(1/6) two-particle 1d solution
%   W = N 3D points.
%   Wnew = perturbed copy of W
%   Ea = (not used) average energy.
%   T = (not used) current temperature.
%
%   Perturbs a cluster either (random choice) by 
%       compression or expansion.  The latter is
%       acheived by the satools method "stillinger3Dpoints".
%   
N = X(1) ;
g = X(4) ;
rho = X(5) ;
if rand < 0.5       % to compress or expand, that is the question!
    Wnew = g*W ;
else
    Wnew = stillinger3Dpoints(W,N,rho) ;
end
