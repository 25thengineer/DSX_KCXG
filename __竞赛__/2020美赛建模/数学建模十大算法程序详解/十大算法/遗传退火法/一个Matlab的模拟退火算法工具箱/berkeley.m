function T = berkeley(Ea,Estd,walkers,dEtgt,v,e,T,t,P)
% Berkeley temperature update method supplied with SA Tools.
% Copyright (c) 2002, by Richard Frost and Frost Concepts.
% See http://www.frostconcepts.com/software for information on SA Tools.
%
%   T = berkeley(Ea,Estd,walkers,dEtgt,v,e,T,t,P) ;
%
%   Ea = (not used) average energy.
%   Estd = standard deviation of energies
%   walkers = number of walkers
%   dEtgt = (not used) difference between present and previous target mean energy
%   v = (not used) thermodynamic speed.
%   e = (not used) estimate of relaxation time.
%   T = current temperature.
%   t = (not used) temperature step #.
%   P = positive constant < 1.
%
if (P <= 0) | (1 <= P)
    error(sprintf('berkeley method requires 0 < P < 1  (was: %g)',P)) ;
end
if T > 0
    if Estd > 0
        dT = -P*(T*T)/Estd ;
    else
        dT = T ;  % force algorithm into next if statement
    end
    if T <= abs(dT)
        dT = -P*T ;  % when dT out of range, use recommended geometric approximation
    end
    T = T + dT ;
end
