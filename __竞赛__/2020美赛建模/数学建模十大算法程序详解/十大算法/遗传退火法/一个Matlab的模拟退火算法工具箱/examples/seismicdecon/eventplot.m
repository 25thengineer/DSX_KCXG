function h = eventplot(X)
% h = eventplot(X)
% Method for seismicdecon example supplied with SA Tools.
% See http://www.frostconcepts.com/software for information on SA Tools.
%
%   h = eventplot(X) ;
%
%   X = {K L t f g}
%       K = length of alpha, tau vectors
%       L = length of source and detected signals
%       t = time vector
%       f = source signal
%       g = detected signal
%   h = handle to plot
%
%   plots time series associated with problem
%
t = X{3} ;
f = X{4} ;
g = X{5} ;
h = plot(t,f,'b') ;
hold on ;
plot(t,g,'r') ;
hold off ;
