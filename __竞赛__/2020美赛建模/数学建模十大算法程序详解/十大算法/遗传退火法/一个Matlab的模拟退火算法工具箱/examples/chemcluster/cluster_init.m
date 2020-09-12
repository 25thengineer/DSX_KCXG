function X = cluster_init(N,a,b,g)
% X = cluster_init(N,a,b,g) ;
% Method for chemcluster example supplied with SA Tools.
% See http://www.frostconcepts.com/software for information on SA Tools.
%
%   X = cluster_init ;
%   X = cluster_init(N) ;
%   X = cluster_init(N,a,b) ;
%   X = cluster_init(N,a,b,g) ;
%
%   X = [N,a,b,g,rho]
%   N = number of molecules
%   a = Lennard-Jones coefficient
%   b = Lennard-Jones coefficient
%   g = compression factor used in perturb
%   rho = (b/a)^(1/6) two-particle 1d solution
%
% Sets and stores parameters for Lennard-Jones simulation.
% a and b must be positive scalars.
% g must be a positive scalar, typically < 1.
% Execute without arguments to determine default values.
%
if nargin < 4           % set default values of parameters as needed
    g = .97 ;
    if nargin < 3
        a = 4 ;
        b = 3 ;
        if nargin < 1
            N = 7 ;
        end
    end
end
rho = (b/a)^(1/6) ;     % compute for later use
X = [N,a,b,g,rho] ;
