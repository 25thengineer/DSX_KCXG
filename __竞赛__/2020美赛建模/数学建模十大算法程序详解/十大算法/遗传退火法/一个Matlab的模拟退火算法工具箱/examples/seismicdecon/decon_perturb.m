function Wnew = decon_perturb(X,W,Ea,T)
% Mnew = decon_perturb(X,W)
% Method for seismicdecon example supplied with SA Tools.
% See http://www.frostconcepts.com/software for information on SA Tools.
%
%   Mnew = decon_perturb(X,W,Ea,T) ;
%
%   X = (not used) problem definition
%   W = {alpha tau K}
%       alpha = attenuation values
%       tau = translation values
%       K = length of alpha, tau vectors
%   Ea = (not used) average energy.
%   T = (not used) current temperature.
%
%   Perturbs a random element of alpha or tau (not both).
%   Checks to make sure perturbation is within reasonable bounds.
%
[alpha,tau,K] = modelparts(W) ;
choice = rand ;
element = ceil(rand*K) ;
amount = rand ;
if choice < .5
    % perturb alpha
    alpha(element) = (0.5 + rand)*alpha(element) ;
    if alpha(element) < 0
        alpha(element) = 0 ;
    elseif alpha(element) > 1
        alpha(element) = 1 ;
    end
else
    % perturb tau
    tau(element) = ceil((0.5 + rand)*tau(element)) ;
    if tau(element) < 0
        tau(element) = 0 ;
    elseif tau(element) > 2000
        tau(element) = 2000 ;
    end
end
Wnew = {alpha tau K} ;