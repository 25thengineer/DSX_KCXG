function S = clusterdistances(W,N)
% S = clusterdistances(W,N)
% Method for chemcluster example supplied with SA Tools.
% See http://www.frostconcepts.com/software for information on SA Tools.
%
%   S = clusterdistances(W,N) ;
%
%   W = N 3D points;  W(1:N,1:3)
%   N = number of points
%   S = point-to-point distances
%
k = 1 ;
for j=1:(N-1)
    for i=(j+1):N
        S(k) = norm(W(j,1:3) - W(i,1:3)) ;
        k = k + 1;
        end
    end
end
