function [W,Ew,Wbsf,Ebsf,Ea,Estd,Ev,steps] = metropoliswalk( ...
        verbose, ...
        Ea, T, ...
        walkers, W, X, cost, moveclass, ...
        acceptrule, q, ...
        hasEquilibrate, equilibrate, C, maxsteps, ...
        Wbsf, Ebsf)
% Metropolis search (at constant temperature) algorithm supplied with SA Tools.
% Copyright (c) 2002, by Richard Frost and Frost Concepts.
% See http://www.frostconcepts.com/software for information on SA Tools.
%
%   [W,Ew,Wbsf,Ebsf,Ea,Estd,Ev,steps] = metropoliswalk( ...
%       verbose, Ea, T, W, X, cost, moveclass, acceptrule, q, maxsteps, Wbsf, Ebsf) ;
%
%   INPUT VALUES:
%   verbose = prints status information when true (1).
%   Ea = average energy.
%   T = current temperature.
%   walkers = number of walkers.  Must be positive integer.
%   W = cell array of user-defined state(s) returned from newstate or moveclass.
%   X = user-defined problem domain or other data, behaviorally static.
%   cost = (handle to) user-defined objective method (function)
%           Ew = cost(X,W)    where
%               X = user-defined problem domain or other data.
%               W = a user-defined state from 'newstate' or 'moveclass'.
%   moveclass = (handle to) user-defined method,
%           W = moveclass(X,W,Ea,T)    where
%               X = user-defined problem domain or other data.
%               W = a user-defined state from 'newstate' or 'moveclass'.
%               Ea = average energy at current temperature.
%               T = current temperature
%   acceptrule = (handle to) SA Tools or user-defined method
%           a = acceptrule(dE,T,q)    where
%               dE = the difference in cost between a trial state and
%                       the current state: dE = Wtrial - W
%               T = the current temperature
%               q = any data required by the acceptrule
%               a = 0 if trial is rejected, otherwise 1.
%           SA Tools supplied methods are:
%               metropolis
%               szu
%               tsallis
%               threshold
%               franz
%   q = any data required by the acceptrule.
%   hasEquilibrate = true (1) when equilibrate is function handle, otherwise false (0).
%   equilibrate = (handle to) SA Tools method, or user-defined method,
%           or a non-function_handle type (e.g., 0).  If a function handle is 
%           supplied, then the temperature will not change (i.e., schedule will
%           not be called) until equilibrate returns false (0).  Otherwise, the
%           moveclass will be executed maxsteps times between each
%           temperature change.  Method signature:
%               c = equilibrate(Ea0,Ea,Ew,walkers,T,step,maxsteps,C)    where
%                   Ea0 = average energy at the beginning of the metropolis walk
%                   Ea = current average energy
%                   Ew = current energies corresponding to W (size walkers)
%                   walkers = the number of walkers in the simulation
%                   T = the current temperature
%                   step = the current number of steps taken in the walk
%                   maxsteps = an upper limit on the number of steps in the walk
%                   C = any behaviorally constant data required by the method
%                   c = 0 if the temperature may change, otherwise 1.
%               SA Tools supplied methods are:
%                   hoffmann    (wait-for-a-fluctuation)
%           Book chapter 13.
%   C = any data required by equilibrate.
%   maxsteps = number of times to call nextstate.
%   Wbsf = cell array of best-so-far user-defined state(s).
%   Ebsf = array of Wbsf energy(ies).
%
%   OUTPUT VALUES:
%   (several input arguments are also output with updated values).
%   Ew = array of energy(ies) of user-defined state.
%   Ea = average energy during walk.
%   Estd = standard deviation of energies during walk.
%   Ev = energy (cost) history at T
%               i = arbitrary index
%               Ev(i,1) = step #
%               Ev(i,2) = walker #
%               Ev(i,3) = an energy visited during T
%               Ev(i,4) = energy attempted from Ev(i,1:3) during T
%   steps = actual number of steps taken by each walker.
%
Ev(1,1:4) = 0 ;
Ew(1:walkers) = Inf ;
i = 1 ;
k = 1 ;
walking = 1 ;
Ea0 = Ea ;
E = [] ;
%
% take a metropolis walk
%
while walking
    for j=1:walkers
        [W{j},Ew(j),Evisit,Etrial] = nextstate(Ea,T,W{j},X,cost,moveclass,acceptrule,q) ;
        Ev(i,1) = k ;
        Ev(i,2) = j ;
        Ev(i,3) = Evisit ;
        Ev(i,4) = Etrial ;
        if Ew(j) < Ebsf(j)
            Wbsf{j} = W{j} ;
            Ebsf(j) = Ew(j) ;
        end
        i = i + 1 ;
    end
    %
    % update metrics
    %
    E = cat(2,E,Ew) ;
    Ea = mean(E) ;
    Estd = std(E) ;
    %
    % test for equilibration
    %
    if hasEquilibrate
        walking = feval(equilibrate,Ea0,Ea,Ew,walkers,T,k,maxsteps,C) ;
    else
        walking = (k < maxsteps) ;
    end
    k = k + 1 ;
end
steps = k - 1 ;
