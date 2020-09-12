function T = thermospeedR(Ea,Estd,walkers,dEtgt,v,e,T,t,P)
% Heat capacity thermospeed temperature update method supplied with SA Tools.
% Copyright (c) 2002, by Richard Frost and Frost Concepts.
% See http://www.frostconcepts.com/software for information on SA Tools.
%
%   T = thermospeedR(Ea,Estd,walkers,dEtgt,v,e,T,t,P) ;
%
%   Ea = (not used) average energy.
%   Estd = standard deviation of energies
%   walkers = (not used) number of walkers
%   dEtgt = (not used) difference between present and previous target mean energy
%   v = thermodynamic speed.
%   e = estimate of relaxation time.
%   T = current temperature.
%   t = (not used) temperature step #.
%   P = (not used) constant
%
%   Temperature will not change if
%       1. Estd or e are zero
%       2. Input T is negative, zero, or infinite
%       3. The calculated temperature would be negative
%
if (Estd == 0) | (e == 0) | (T <= 0) | (T == Inf)
    dT = 0 ;
else
    dT = -v*((T*T)/(e*Estd)) ;
    if dT < -T
        dT = 0 ;        % do nothing if unstable
    end
end
T = T + dT ;
