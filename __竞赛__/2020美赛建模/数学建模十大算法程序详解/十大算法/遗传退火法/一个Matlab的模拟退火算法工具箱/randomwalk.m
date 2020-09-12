function [W,Ew,Wbsf,Ebsf,Ea,Ev] = randomwalk(steps, walkers, newstate, X, cost, moveclass)
% Random walk method supplied with SA Tools.
% Copyright (c) 2002, by Richard Frost and Frost Concepts.
% See http://www.frostconcepts.com/software for information on SA Tools.
%
%   [W,Ew,Wbsf,Ebsf,Ea,Ev] = randomwalk(steps, walkers, newstate, X, cost, moveclass) ;
%
%   INPUTS:
%       steps = the number of random steps to talk
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
%       W = cell array of user-defined state(s) from 'newstate' or 'moveclass'.
%       Ew = current energies corresponding to W (size walkers)
%       Ev = energy (cost) history at T  (T is Inf in random walk)
%               i = arbitrary index
%               Ev(i,1) = step #
%               Ev(i,2) = walker #
%               Ev(i,3) = an energy visited during T
%               Ev(i,4) = energy attempted from Ev(i,1:3) during T
%       Wbsf = cell array of best-so-far states of size 'walkers'
%       Ebsf = array of best-so-far energies
%       Ea = average energy
%
%   Calls ensembleInit(...) and then performs random walk accepting all moves.
%
[W,Ew,Wbsf,Ebsf,Ea] = ensembleInit(walkers, newstate, X, cost) ;
i = 1 ;
E = Ew ;
for k=1:steps
    for j=1:walkers
        Ev(i,1) = i ;
        Ev(i,2) = j ;
        Ev(i,3) = Ew(j) ;
        W{j} = feval(moveclass,X,W{j},Ea,Inf) ;
        Ew(j) = feval(cost,X,W{j}) ;
        if Ew(j) < Ebsf
            Wbsf{j} = W{j} ;
            Ebsf(j) = Ew(j) ;
        end
        Ev(i,4) = Ew(j) ;
        i = i + 1 ;
    end
    E = cat(2,E,Ew) ;
end
Ea = mean(E) ;
