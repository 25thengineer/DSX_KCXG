function Eh = historyupdate(Eh,Ev,t,T)
% Temperature & Energy history update method supplied with SA Tools.
% Copyright (c) 2002, by Richard Frost and Frost Concepts.
% See http://www.frostconcepts.com/software for information on SA Tools.
%
%    Eh = historyupdate(Eh,Ev,t,T)
%        INPUT:
%            Eh = previous Eh array
%            Ev = energy (cost) history at T
%                   i = arbitrary index
%                   Ev(i,1) = step #
%                   Ev(i,2) = walker #
%                   Ev(i,3) = an energy visited during T
%                   Ev(i,4) = energy attempted from Ev(i,1:3) during T
%            t = index of current temperature step
%            T = current temperature
%        OUTPUT:
%            Eh = energy and temperature history
%                   i = 1, ..., 1+(steps*walkers), etc.
%                   Eh(i,1) = index t of temperature step
%                   Eh(i,2) = T corresponding to t
%                   Eh(i,3) = equilibrium step #j at T
%                   Eh(i,4) = walker #k
%                   Eh(i,5) = energy E visited by walker k at step j during T
%                   Eh(i,6) = energy E' attempted from E by walker k at step j during T
%
sizeEh = size(Eh) ;
sizeEv = size(Ev) ;
m = sizeEh(1) ;
n = sizeEv(1) ;
clear sizeEh sizeEv ;
for i=1:n
    m = m + 1 ;
    Eh(m,1) = t ;
    Eh(m,2) = T ;
    Eh(m,3:6) = Ev(i,1:4) ;
end
    