function [Cnew,overlapped] = stillinger3Dpoints(C,N,u)
% Stillinger 3D point cluster algorithm supplied with SA Tools.
% Copyright (c) 2002, by Richard Frost and Frost Concepts.
% See http://www.frostconcepts.com/software for information on SA Tools.
%
%   Cnew = stillinger3Dpoints(C,N,u) ;
%
%   C = N 3D points;  C(1:N,1:3)
%   N = number of points
%   u = approximate optimal separation
%   Cnew = perturbed copy of C
%   overlapped = equals 1 if C contained points separated by less than u, 0 otherwise
%
%   If no overlapped points are found then the relative positions of the points
%   will not change.
%
%   Regardless of whether overlap is found, the centroid of the cluster will be
%   computed and then all points will be linearly translated so that the centroid
%   is at the origin.
%
overlapped = 0 ;
for j=1:N
    p(j,1:3) = 0 ;
    for i=1:(j-1)
        s = C(j,1:3) - C(i,1:3) ;
        d = norm(s) ;
        if d < u
            overlapped = 1 ;
            dd = ((u - d) / 2)*(.9 + (rand*.2)) ;
            p(j,1:3) = p(j,1:3) + ((dd/d)*s(1:3)) ;
        end
    end
    for i=(j+1):N
        s = C(j,1:3) - C(i,1:3) ;
        d = norm(s) ;
        if d < u
            overlapped = 1 ;
            dd = ((u - d) / 2)*(.9 + (rand*.2)) ;
            p(j,1:3) = p(j,1:3) + ((dd/d)*s(1:3)) ;
        end
    end
end
b(1:3) = 0 ;
for j=1:N
    Cnew(j,1:3) = C(j,1:3) + p(j,1:3) ;
    b(1:3) = b(1:3) + Cnew(j,1:3) ;
end
b = (b/N) ;
for j=1:N
    Cnew(j,1:3) = Cnew(j,1:3) - b(1:3) ;
end
