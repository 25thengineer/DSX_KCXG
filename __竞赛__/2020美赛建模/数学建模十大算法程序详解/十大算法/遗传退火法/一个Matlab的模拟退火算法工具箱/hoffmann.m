function b = hoffmann(Ea0,Ea,Ew,walkers,T,step,maxsteps,C)
% Equilibration method supplied with SA Tools.
% Copyright (c) 2002, by Richard Frost and Frost Concepts.
% See http://www.frostconcepts.com/software for information on SA Tools.
%
%    b = hoffmann(Ea0,Ea,Ew,walkers,T,step,maxsteps,C)
%
%   INPUT:
%        Ea0 = average energy at the beginning of the metropolis walk
%        Ea = current average energy
%        Ew = current energies corresponding to W (size walkers)
%        walkers = the number of walkers in the simulation
%        T = the current temperature
%        step = the current number of steps taken in the walk
%        maxsteps = an upper limit on the number of steps in the walk
%        C = problem dependent positive scalar constant
%   OUTPUT:
%        b = 0 if the temperature may change, otherwise 1.
%
%        b will be 0 whenever:
%           1. the number of equalibrium steps has reached or exceeded maxsteps
%           2. the change in average energy DE satisfies
%                   DE  <  C * std(Ew) / sqrt(walkers)
%              In other words, a fraction (C / sqrt(walkers)) of the
%              standard deviation of energies exceeds the change in average energy.
%
if C <= 0
    error(sprintf('hoffmann method requires 0 < C  (was: %g)',C)) ;
end
if step >= maxsteps
    b = 0 ;
else
    DE = abs(Ea - Ea0) ;
    Crit = (C*std(Ew))/sqrt(walkers) ;
    b = (DE < Crit) ;
end
