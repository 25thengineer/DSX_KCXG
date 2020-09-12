function j = Jcoord(w,d,h,width,depth,height)
% j = Jcoord(w,d,h)
% Method for spinglass example supplied with SA Tools.
% See http://www.frostconcepts.com/software for information on SA Tools.
%
%   j = Jcoord(w,d,h,width,depth,height) ;
%
%       w,d,h = coordinates in lattice L.  Assumed positive.
%       width,depth,height = size of lattice dimensions.
%       j = index in coupling matrix J
%
%       (1,1,1) = 1
%       (1,1,h) = h
%       (1,2,1) = (2-1)*height + 1
%       (1,d,h) = (d-1)*height + h
%       (2,1,1) = depth*height + 1
%       (2,1,h) = depth*height + h
%       (2,d,h) = depth*height + (d-1)*height + h
%       (w,d,h) = (w-1)*depth*height + (d-1)*height + h
%
j = ((w-1)*depth*height) + ((d-1)*height) + h ;