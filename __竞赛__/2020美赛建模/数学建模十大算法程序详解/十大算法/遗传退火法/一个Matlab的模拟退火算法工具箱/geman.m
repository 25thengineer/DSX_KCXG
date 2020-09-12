function T = geman(Ea,Estd,walkers,dEtgt,v,e,T,t,P)
% Geman temperature update method supplied with SA Tools.
% Copyright (c) 2002, by Richard Frost and Frost Concepts.
% See http://www.frostconcepts.com/software for information on SA Tools.
%
%   T = geman(Ea,Estd,walkers,dEtgt,v,e,T,t,P) ;
%
%   Ea = (not used) average energy.
%   Estd = (not used) standard deviation of energies
%   walkers = (not used) number of walkers
%   dEtgt = (not used) difference between present and previous target mean energy
%   v = (not used) thermodynamic speed.
%   e = (not used) estimate of relaxation time.
%   T = (not used) current temperature.
%   t = temperature step #.
%   P = positive constant
%
%   if T > 0
%       T = P / log(t+1) ;
%   end
%
if P <= 0
    error(sprintf('geman method requires 0 < P  (was: %g)',P)) ;
end
if T > 0
    T = P / log(t+1) ;
end
