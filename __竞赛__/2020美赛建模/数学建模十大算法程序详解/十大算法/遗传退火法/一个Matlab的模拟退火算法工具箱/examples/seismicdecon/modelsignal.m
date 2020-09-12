function s = modelsignal(f,L,alpha,tau,K)
% s = modelsignal(f,L,alpha,tau,K)
% Method for seismicdecon example supplied with SA Tools.
% See http://www.frostconcepts.com/software for information on SA Tools.
%
%   s = modelsignal(f,L,alpha,tau,K) ;
%
%   f = source signal
%   L = length of source signal
%   alpha = attenuation values
%   tau = translation values
%   K = length of alpha, tau vectors
%
%   Computes a signal s from the input model parameters.
%
for n = 1:L,
    s(n) = 0 ;
    for i = 1:K,
        k = n - tau(i) ;
        if k > 0
            s(n) = s(n) + (alpha(i)*f(k)) ;
        end
    end ;
end ;

