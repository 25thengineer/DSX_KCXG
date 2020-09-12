function [alpha,tau,K] = modelparts(W)
% [alpha,tau,K] = modelparts(W)
% Method for seismicdecon example supplied with SA Tools.
% See http://www.frostconcepts.com/software for information on SA Tools.
%
%   [alpha,tau,K] = modelparts(W) ;
%
%   W = {alpha tau K}
%       alpha = attenuation values
%       tau = translation values
%       K = length of alpha, tau vectors
%
%   Convenience utility.
%
alpha = W{1} ;
tau = W{2} ;
K = W{3} ;
