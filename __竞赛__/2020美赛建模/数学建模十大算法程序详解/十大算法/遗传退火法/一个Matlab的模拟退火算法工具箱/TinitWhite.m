function [T0,W,Ew,Wbsf,Ebsf,Ea,Ev,steps] = TinitWhite(r, walkers, newstate, X, cost, moveclass)
% White temperature initialization method supplied with SA Tools.
% Copyright (c) 2002, by Richard Frost and Frost Concepts.
% See http://www.frostconcepts.com/software for information on SA Tools.
%
%   [T0,W,Ew,Wbsf,Ebsf,Ea,Ev,steps] = TinitWhite(r, walkers, newstate, X, cost, moveclass) ;
%
%   INPUTS:
%       r = [ratio, steps]  where
%               ratio = scale of stddev(E|infinity) to set initial temperature (e.g., 2.0)
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
%   Sets T0 to user supplied ratio of standard deviation of infinite temperature energies.
%   Calls randomwalk(...).
%
ratio = r(1) ;
if ratio <= 0
    error(sprintf('Ratio in TinitWhite must be > 0  (was: %g)', ratio)) ;
end
steps = r(2) ;
if steps <= 0
    error(sprintf('Steps in TinitWhite must be > 0 (was: %g)', steps)) ;
end
N = steps*walkers ;
if N < 2
    error(sprintf('steps*walkers in TinitWhite must be > 1 (was: %g)', N)) ;
end
%
[W,Ew,Wbsf,Ebsf,Ea,Ev] = randomwalk(steps, walkers, newstate, X, cost, moveclass) ;
%
if walkers == 1
    E(1) = Ew(1) ;
    E(2:(steps+1)) = Ev(:,3) ;
    T0 = ratio * std(E) ;
else
    T0 = ratio * std(Ew) ;
end
