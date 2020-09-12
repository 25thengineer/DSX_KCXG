function dispEt(Tt,Et,Etarget,ert,Kt,Ebsft)
% Et data display method supplied with SA Tools.
% Copyright (c) 2002, by Richard Frost and Frost Concepts.
% See http://www.frostconcepts.com/software for information on SA Tools.
%
% dispEt(Tt,Et,Etarget,Kt,Ebsft)
%
%   Tt(i) = temperature at temperature step i-1
%   Et(i) = average energy at Tt(i)
%   Etarget(i) = target average energy for Tt(i+1)
%   ert(i) = estimate of relaxation time at Tt(i)
%   Kt(i) = number of equilibration steps taken at Tt(i)
%   Ebsft(i) = best-so-far energy at Tt(i)
%
newline = sprintf('\n') ;
tab = sprintf('\t') ;
sizeTt = size(Tt) ;
m = sizeTt(2) ;
disp(sprintf('%8s %12s %12s %12s %12s %12s %12s %12s','t','T','<E>','Etarget','e','steps','Ebsf')) ;
for i=1:m
    disp(sprintf('%8d %12.5g %12.5g %12.5g %12.5g %12d %12.5g', ...
        round(i-1),Tt(i), Et(i), Etarget(i), ert(i), round(Kt(i)), Ebsft(i))) ;
end
disp([tab]) ;
    