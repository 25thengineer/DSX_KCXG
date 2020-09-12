function dispEh(Eh)
% Eh matrix display method supplied with SA Tools.
% Copyright (c) 2002, by Richard Frost and Frost Concepts.
% See http://www.frostconcepts.com/software for information on SA Tools.
%
% dispEh(Eh)
%
%   Eh = energy and temperature history
%          i = 1, 1+(steps*walkers), etc.
%          Eh(i,1) = index t of temperature step
%          Eh(i,2) = T corresponding to t
%          Eh(i,3) = equilibrium step #j at T
%          Eh(i,4) = walker #k
%          Eh(i,5) = energy E visited by walker k at step j during T
%          Eh(i,6) = energy E' attempted from E by walker k at step j during T
%
    newline = sprintf('\n') ;
    tab = sprintf('\t') ;
    sizeEh = size(Eh) ;
    m = sizeEh(1) ;
    disp(sprintf('%12s %12s %12s %12s %12s %12s','t','T','step','walker','E','E"')) ;
    for i=1:m
        disp(sprintf('%12d %12.5g %12d %12d %12.5g %12.5g', ...
            round(Eh(i,1)),Eh(i,2),round(Eh(i,3)),round(Eh(i,4)),Eh(i,5),Eh(i,6))) ;
    end
    disp([tab]) ;
    