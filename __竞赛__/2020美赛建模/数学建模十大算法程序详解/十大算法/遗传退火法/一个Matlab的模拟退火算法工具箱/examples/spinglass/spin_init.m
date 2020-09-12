function [X,L] = spin_init(width, depth, height)
% [X,L] = spin_init(width, depth, height)
% Method for spinglass example supplied with SA Tools.
% See http://www.frostconcepts.com/software for information on SA Tools.
%
%   [X,L] = spin_init(width, depth, height) ;
%
%   width, height, depth = dimensions of 3D lattice.
%       must be positive integers.
%   X = {n, J}
%       n = size of coupling matrix, n = width*depth*height
%       J = restricted range coupling matrix
%   L = lattice from which coupling coupling matrix is derived
%
%   Generates X and L from lattice size parameters.
%   Any particular triplet of input values will always produce the same lattice.
%       e.g., new_coupling(3,4,5) always produces the same X and L.
%
width = floor(width) ;
depth = floor(depth) ;
height = floor(height) ;
if (width < 1) | (depth < 1) | (height < 1)
    error(sprintf('width, depth, and height must be positive.  was: %g %g %g', width, depth, height)) ; 
end
%
%  Create lattice
%
S = rand('state') ;                     % save the state of the random number generator
rand('state',102302) ;                  % set rand to this state
L(1:width,1:depth,1:height) = 0 ;
n = width*depth*height ;
k = (3*n) / 4 ;                         % lattice "population"
for i=1:k
    w = floor(rand*width) + 1 ;
    d = floor(rand*depth) + 1 ;
    h = floor(rand*height) + 1 ;
    L(w,d,h) = L(w,d,h) + 1 ;
end
%
%   O.K., now create coupling matrix
%
J(1:n,1:n) = 0 ;
for w=1:width
    for d=1:depth
        for h=1:height
            if L(w,d,h) > 0
                j = Jcoord(w,d,h,width,depth,height) ;
                amin = max(1,w-1) ;
                amax = min(width,w+1) ;
                bmin = max(1,d-1) ;
                bmax = min(depth,d+1) ;
                cmin = max(1,h-1) ;
                cmax = min(height,h+1) ;
                for a=amin:amax
                    for b=bmin:bmax
                        for c=cmin:cmax
                            if (a ~= w) | (b ~= d) | (c ~= h)
                                i = Jcoord(a,b,c,width,depth,height) ;
                                J(i,j) = J(i,j) + L(w,d,h) ;
                            end
                        end
                    end
                end
            end
        end
    end
end
%
%   Finally, set magnitudes of J to a random fraction of the number of inputs
%
for i=1:n
    for j=1:n
        J(i,j) = J(i,j)* rand ;
    end
end
%
rand('state',S) ;                  % reset rand to original state
X = {n, J} ;
