function [T0,W,Ew,Wbsf,Ebsf,Ea,Ev,steps] = TinitAccept(r, walkers, newstate, X, cost, moveclass)
% Acceptance ratio temperature initialization method supplied with SA Tools.
% Copyright (c) 2002, by Richard Frost and Frost Concepts.
% See http://www.frostconcepts.com/software for information on SA Tools.
%
%   [T0,W,Ew,Wbsf,Ebsf,Ea,Ev,steps] = TinitAccept(r, walkers, newstate, X, cost, moveclass) ;
%
%   INPUTS:
%       r = [ratio, steps]  where
%               ratio = the fraction of uphill moves that T0 should accept (e.g., 0.5)
%               steps = the number of random steps to determine T0  (e.g., 5)
%       walkers = number of walkers.  Must be positive integer.
%       newstate = (handle to) user-defined method
%           W0 = newstate(X)    where
%               X = user-defined problem domain or other data,
%                       behaviorally static.
%               W0 = an initial user-defined state.
%       X = user-defined problem domain or other data, behaviorally static.
%       cost = (handle to) user-defined objective method (function)
%           Ew = cost(X,W)    where
%               X = user-defined problem domain or other data.
%               W = a user-defined state from 'newstate' or 'moveclass'.
%       moveclass = (handle to) user-defined method,
%           W = moveclass(X,W,Ea,T)    where
%               X = user-defined problem domain or other data.
%               W = a user-defined state from 'newstate' or 'moveclass'.
%               Ea = average energy at current temperature.
%               T = current temperature (will be infinite in Tinit)
%   OUTPUTS:
%       T0 = initial temperature
%       W = cell array of user-defined state(s) from 'newstate' or 'moveclass'.
%       Ew = current energies corresponding to W (size walkers)
%       Wbsf = array of best-so-far states of size 'walkers'
%       Ebsf = array of best-so-far energies
%       Ea = average energy
%       Ev = energy (cost) history at T
%               i = arbitrary index
%               Ev(i,1) = step #
%               Ev(i,2) = walker #
%               Ev(i,3) = an energy visited during T
%               Ev(i,4) = energy attempted from Ev(i,1:3) during T (will be infinite in Tinit)
%       steps = # of steps taken by each walker during Tinit
%
%   Sets T0 so that fraction r of the states examined in this function
%   would be accepted by metropolis acceptance rule.
%
ratio = r(1) ;
if (ratio < 0) | (1 < ratio)
    error(sprintf('Ratio in TinitAccept must be in range [0,1]  (was: %g)', ratio)) ;
end
steps = r(2) ;
if steps <= 0
    error(sprintf('Steps in TinitAccept must be > 0 (was: %g)', steps)) ;
end
%
% take a random walk
%
[W,Ew,Wbsf,Ebsf,Ea,Ev] = randomwalk(steps, walkers, newstate, X, cost, moveclass) ;
%
% compute array dE containing the energy differences between neighbor states in the walk
%
L = steps*walkers ;
k = 0 ;
for i = 1:L
    d = abs(Ev(i,3) - Ev(i,4)) ;
    if d ~= 0
        k = k + 1 ;
        dE(k) = d ;
    end
end
if k == 0
    error('No difference in energies of states.  TinitAccept cannot continue.') ;
end
%
% Will use bisection search to find value that satisfies acceptance ratio.
% The objective function is  sum(exp(-dE/T)) + b.
%
b = ratio*k ;
%
% Find lower bound for bisection search.
%
Tmin = 1 ;
S = exp(-dE/Tmin) ;
fmin = sum(S) - b ;
while fmin > 0
    Tmin = 0.5 * Tmin ;
    if Tmin == 0
        fmin = -b ;
    else
        S = exp(-dE/Tmin) ;
        fmin = sum(S) - b ;
    end
end
%
% Find upper bound for bisection search.
%
Tmax = Tmin ;
if Tmax == 0
    fmax = -b ;
else
    S = exp(-dE/Tmax) ;
    fmax = sum(S) - b ;
end
while fmax < 0
    Tmax = (2 * Tmax) + 1 ;
    S = exp(-dE/Tmax) ;
    fmax = sum(S) - b ;
end
%
% Perform bisection search with error tolerance of 10^-6.
%
T0 = 0.5 * (Tmin + Tmax) ;
relerr = abs((Tmax-Tmin)/Tmax) ; 
errtol = 0.000001 ;
while relerr > errtol
    S = exp(-dE/T0) ;
    fmid = sum(S) - b ;
    if (fmid < 0)
        Tmin = T0 ;
        fmin = fmid ;
    else
        Tmax = T0 ;
        fmax = fmid ;
    end
    relerr = abs((Tmax-Tmin)/Tmax) ; 
    T0 = 0.5 * (Tmin + Tmax) ;
end
%
