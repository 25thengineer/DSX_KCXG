function [T0,W,Ew,Wbsf,Ebsf,Ea,Ev,steps] = TinitT0(r, walkers, newstate, X, cost, moveclass)
% Fixed temperature initialization method supplied with SA Tools.
% Copyright (c) 2002, by Richard Frost and Frost Concepts.
% See http://www.frostconcepts.com/software for information on SA Tools.
%
%   [T0,W,Ew,Wbsf,Ebsf,Ev,steps] = TinitT0(r, walkers, newstate, X, cost, moveclass) ;
%
%   INPUTS:
%       r = initial temperature T0
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
%       W = user-defined state(s) from 'newstate' or 'moveclass'.
%       Ew = current energies corresponding to W (size walkers)
%       Wbsf = array of best-so-far states of size 'walkers'
%       Ebsf = array of best-so-far energies
%       Ea = average energy
%       Ev = energy (cost) history at T
%               i = arbitrary index
%               Ev(i,1) = step #
%               Ev(i,2) = walker #
%               Ev(i,3) = an energy visited during T
%               Ev(i,4) = energy attempted from Ev(i,1:3) during T
%       steps = # of steps taken by each walker during Tinit
%
%   Sets T0 to the user supplied value.  Calls ensembleInit(...).
%
[W,Ew,Wbsf,Ebsf,Ea] = ensembleInit(walkers, newstate, X, cost) ;
T0 = r ;
Ev = [] ;
steps = 0 ;
    