function W = decon_new(X)
% W = decon_new(X)
% Method for seismicdecon example supplied with SA Tools.
% See http://www.frostconcepts.com/software for information on SA Tools.
%
%   W = decon_new(X) ;
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
%
%   Creates a trial solution {alpha tau} for the problem parameters given in X.
%   The same solution is created for each value of K.
%
K = X{1} ;
I = 1:K ;
for i=I,
    alpha(i) = 1/log(i+1) ;
end
alpha = alpha / sum(alpha) ;
tau = (1000/K)*I ;
W = {alpha tau K} ;
