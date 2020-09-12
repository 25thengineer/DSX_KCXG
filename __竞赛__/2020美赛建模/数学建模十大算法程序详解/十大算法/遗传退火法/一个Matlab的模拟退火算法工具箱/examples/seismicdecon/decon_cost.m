function c = decon_cost(X,W)
% c = decon_cost(X,W)
% Method for seismicdecon example supplied with SA Tools.
% See http://www.frostconcepts.com/software for information on SA Tools.
%
%   c = decon_cost(X,W) ;
%
%   X = {K L t f g}
%       K = length of alpha, tau vectors
%       L = length of source and detected signals
%       t = time vector
%       f = source signal
%       g = detected signal
%   W = {alpha tau K}
%       alpha = attenuation values
%       tau = translation values
%       K = length of alpha, tau vectors
%   c = goodness of fit between W and X
%
%   Calls modelsignal(...) to compute a signal s from alpha and tau given in W.
%   Computes cost using infinity norm:
%       c = max(abs(g - s))
%
[K,L,t,f,g] = eventparts(X) ;
[alpha,tau,K] = modelparts(W) ;
s = modelsignal(f,L,alpha,tau,K) ;
c = max(abs(g - s)) ;