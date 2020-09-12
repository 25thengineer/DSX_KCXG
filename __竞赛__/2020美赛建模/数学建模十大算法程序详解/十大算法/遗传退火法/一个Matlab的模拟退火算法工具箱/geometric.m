function T = geometric(Ea,Estd,walkers,dEtgt,v,e,T,t,P)
% Geometric temperature update method supplied with SA Tools.
% Copyright (c) 2002, by Richard Frost and Frost Concepts.
% See http://www.frostconcepts.com/software for information on SA Tools.
%
%   T = geometric(Ea,Estd,walkers,dEtgt,v,e,T,t,P) ;
%
%   Ea = (not used) average energy.
%   Estd = (not used) standard deviation of energies
%   walkers = (not used) number of walkers
%   dEtgt = (not used) difference between present and previous target mean energy
%   v = (not used) thermodynamic speed.
%   e = (not used) estimate of relaxation time.
%   T = current temperature.
%   t = (not used) temperature step #.
%   P = constant: 0 < P <= 1.
%
if (P <= 0) | (1 < P)
    error(sprintf('geometric method requires 0 < P <= 1  (was: %g)',P)) ;
end
if T > 0
    T = T*P ;
end
