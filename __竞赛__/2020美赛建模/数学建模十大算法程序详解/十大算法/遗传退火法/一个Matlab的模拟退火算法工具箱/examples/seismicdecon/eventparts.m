function [K,L,t,f,g] = eventparts(X)
% [K,L,t,f,g] = eventparts(X)
% Method for seismicdecon example supplied with SA Tools.
% See http://www.frostconcepts.com/software for information on SA Tools.
%
%   [K,L,t,f,g] = eventparts(X) ;
%
%   X = {K L t f g}
%   K = length of alpha, tau vectors
%   L = length of source and detected signals
%   t = time vector
%   f = source signal
%   g = detected signal
%
%   Convenience utility.
%
K = X{1} ;
L = X{2} ;
t = X{3} ;
f = X{4} ;
g = X{5} ;