function [X,M,noise] = decon_init(alpha,tau,noise)
% [X,M,noise] = decon_init(alpha,tau,noise)
% Method for seismicdecon example supplied with SA Tools.
% See http://www.frostconcepts.com/software for information on SA Tools.
%
%   [X,M,noise] = decon_init ;
%   [X,M,noise] = decon_init(noise) ;
%   [X,M,noise] = decon_init(alpha,tau) ;
%   [X,M,noise] = decon_init(alpha,tau,noise) ;
%
%   X = {K L t f g}
%       K = length of alpha, tau vectors
%       L = length of source and detected signals
%       t = time vector
%       f = source signal
%       g = detected signal
%   M = {alpha tau K}     (True Model)
%       alpha = attenuation values
%       tau = translation values
%       K = length of alpha, tau vectors
%   noise = scalar noise factor
%
%   Initializes parameters of a toy seismic deconvolution problem.
%   A real problem would read in the signals t, f, and g from source files.
%   Here, the simple model coefficients alpha and tau are supplied (default)
%       or input by the user and used to generate g from an internally supplied f.
%       Consequently, the alpha and tau are the solution to this toy problem.
%
%   If supplied:
%       alpha and tau must be vectors of the same length and contain non-negative values.
%       noise must be a non-negative scalar, typically < 1.
%
%   Execute without arguments to determine default values.
%
if (nargin ~= 1) & (nargin ~= 3)
    noise = 0.1 ;
end
if (nargin ~= 2) & (nargin ~= 3)
    alpha = [  .1,  .4,  .3,  .1, .14, .13, .11, .04, .03, .01 ] ;
    tau =   [ 200, 210, 220, 240, 450, 460, 490, 880, 890, 900 ] ;
end
L = 129 ;
N = (1:L) ;
t = (N-1) / 100.0 ;
for n = N,
    f(n) = 4*exp(-0.5*t(n))*sin(t(n)) ;
end
alphasize = size(alpha) ;
K = alphasize(2) ;
I = 1:K ;
noisemax = noise*mean(f) ;
noisebias = 0.5 * noisemax ;
g = modelsignal(f,L,alpha,tau,K) ;
S = rand('state') ;
rand('state',54845) ;
for n = N,
    g(n) = g(n) + (noisemax*((rand*.2)+.9)*sin(t(n)*t(n)*t(n))) - noisebias ;
end ;
rand('state',S) ;
X = {K L t f g} ;
M = {alpha tau K} ;
