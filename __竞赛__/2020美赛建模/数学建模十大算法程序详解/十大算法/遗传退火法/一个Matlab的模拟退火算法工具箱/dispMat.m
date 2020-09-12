function dispMat(M,name,form)
% Matrix data display method supplied with SA Tools.
% Copyright (c) 2002, by Richard Frost and Frost Concepts.
% See http://www.frostconcepts.com/software for information on SA Tools.
%
% dispMat(M,name,form)
%
%   M = 2D matrix
%   name = text label to display; e.g., 'M'
%   form = numeric print format; e.g, '%4.2f'.  See help format.
%
tab = sprintf('\t') ;
label = sprintf('%s =',name) ;
if nargin == 2
    form = '%5.2f' ;
end
f = sprintf('  %s',form) ;
disp([tab]) ;
disp([tab,label]) ;
n = size(M,1) ;
for i=1:n
    disp([tab,sprintf(f,M(i,:))]) ;
end
disp([tab]) ;
