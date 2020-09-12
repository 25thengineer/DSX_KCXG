function T = thermospeedHC(Ea,Estd,walkers,dEtgt,v,e,T,t,P)
% Heat capacity thermospeed temperature update method supplied with SA Tools.
% Copyright (c) 2002, by Richard Frost and Frost Concepts.
% See http://www.frostconcepts.com/software for information on SA Tools.
%
%   T = thermospeedHC(Ea,Estd,walkers,dEtgt,v,e,T,t,P) ;
%
%   Ea = (not used) average energy.
%   Estd = standard deviation of energies
%   walkers = (not used) number of walkers
%   dEtgt = difference between present and previous target mean energy
%   v = (not used) thermodynamic speed.
%   e = (not used) estimate of relaxation time.
%   T = current temperature.
%   t = (not used) temperature step #.
%   P = (not used) constant
%
%   Temperature will not change if
%       1. Estd is zero
%       2. Input T is negative, zero, or infinite
%       3. The calculated temperature would be negative or infinite
%
if (Estd > 0) & (T > 0) & (T ~= Inf)
    B = 1/T ;                       % use inverse temperature for stability
    dB = -dEtgt / (Estd*Estd) ;
    B = B + dB ;
    if B > 0                        % only change if stable
        T = 1 / B ;
    end
end
