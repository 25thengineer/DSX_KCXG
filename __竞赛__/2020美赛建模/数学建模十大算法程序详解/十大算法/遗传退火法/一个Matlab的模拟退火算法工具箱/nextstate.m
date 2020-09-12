function [W,Ew,Evisit,Etrial] = nextstate(Ea,T,W,X,cost,moveclass,acceptrule,q)
% State-update method supplied with SA Tools.
% Copyright (c) 2002, by Richard Frost and Frost Concepts.
% See http://www.frostconcepts.com/software for information on SA Tools.
%
%   [W,Ew,Evisit,Eattempt] = nextstate(Ea,T,W,neighbor,X,energy) ;
%
%   Ea = average energy.
%   T = current temperature.
%   W = user-defined state.
%   X = user-defined problem domain or other data.
%   cost = (handle to) user-defined cost evaluation method, takes X and W as arguments.
%   moveclass = (handle to) user-defined neighbor generation method,
%       takes X, W, Ea, and T as arguments.
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
%   Ew = energy of user defined state.
%   Evisit = cost of incoming W.
%   Etrial = cost of neighbor state.
%
Ew = feval(cost,X,W) ;
Evisit = Ew ;
Wtrial = feval(moveclass,X,W,Ea,T) ;
Etrial = feval(cost,X,Wtrial) ;
dE = Etrial - Ew ;
if feval(acceptrule,dE,T,q)
    W = Wtrial ;
    Ew = Etrial ;
end
