function h = modelplot(X,W)
% h = modelplot(X,W)
% Method for seismicdecon example supplied with SA Tools.
% See http://www.frostconcepts.com/software for information on SA Tools.
%
%   h = modelplot(X,W) ;
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
%   h = handle to plot
%
%   plots time series associated with trial solution
%
[K,L,t,f,g] = eventparts(X) ;
[alpha,tau,K] = modelparts(W) ;
s = modelsignal(f,L,alpha,tau,K) ;
h = plot(t,s,'k') ;
