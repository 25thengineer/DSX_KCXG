function T = retrospect(Ea,Estd,walkers,dEtgt,v,e,T,t,P)
% Retrospective temperature update method supplied with SA Tools.
% Copyright (c) 2002, by Richard Frost and Frost Concepts.
% See http://www.frostconcepts.com/software for information on SA Tools.
%
%   T = retrospect(Ea,Estd,walkers,dEtgt,v,e,T,t,P) ;
%
%   Ea = (not used) average energy.
%   Estd = (not used) standard deviation of energies
%   walkers = (not used) number of walkers
%   dEtgt = (not used) difference between present and previous target mean energy
%   v = (not used) thermodynamic speed.
%   e = (not used) estimate of relaxation time.
%   T =  (not used) current temperature.
%   t =  temperature step #.
%   P =  array containing temperature schedule; i.e., T(t+1) = P(t).
%
%   If you want temperature schedule
%           Tt = [1000, 100, 10, 1]
%   then set
%           schedule = @retrospect
%           Tinit = 1000
%           P = [100, 10, 1]
%           maxtemps = 4
%
%   If maxtemps exceeds the number of elements in P then the final temperature
%   will be repeated.
%
n = numel(P) ;
if t > n
    T = P(n) ;
else
    T = P(t) ;
end
