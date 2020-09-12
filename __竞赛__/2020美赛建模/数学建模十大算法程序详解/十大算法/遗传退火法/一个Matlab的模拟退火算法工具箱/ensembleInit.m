function [W,Ew,Wbsf,Ebsf,Ea] = ensembleInit(walkers, newstate, X, cost)
% Ensemble initialization method supplied with SA Tools.
% Copyright (c) 2002, by Richard Frost and Frost Concepts.
% See http://www.frostconcepts.com/software for information on SA Tools.
%
%   [W,Ew,Wbsf,Ebsf,Ea] = ensembleInit(walkers, newstate, X, cost) ;
%
%   INPUTS:
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
%   OUTPUTS:
%       W = cell array of user-defined state(s) from 'newstate'.
%       Ew = current energies corresponding to W (size walkers)
%       Wbsf = array of best-so-far states of size 'walkers'
%       Ebsf = array of best-so-far energies
%       Ea = average ensemble energy
%
W = cell(walkers,1) ;
for j=1:walkers
    W{j} = feval(newstate,X) ;
    Ew(j) = feval(cost,X,W{j}) ;
    Wbsf{j} = W{j} ;
    Ebsf(j) = Ew(j) ;
end
Ea = mean(Ew) ;
