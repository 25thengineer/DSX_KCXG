function Ew = sequence_cost(X,W)
% Ew = sequence_cost(X,W)
% Method for proteinfold example supplied with SA Tools.
% See http://www.frostconcepts.com/software for information on SA Tools.
%
%   Ew = sequence_cost(X,W) ;
%
%   X = {N, S SN E}
%       N = length of sequence.
%       S = vector of letters representing sequence.
%       SN = vector of indicies representing sequence, isomorphic to S.
%       E = interaction energies.  E(SN(i),SN(j)) is the interaction energy of i, j.
%
%   W = {edge position} : a valid lattice sequence.
%       edge = N-1 edge directions; e.g., edge(i) = [1, 0, 0]
%       position = N sequence element 3D lattice positions; e.g., position(1) = [0, 0, 0]
%
%   Ew = energy corresponding to W
%
N = X{1} ;
SN = X{3} ;
E = X{4} ;
P = W{2} ;
%
% augment the position matrix to contain position numbers
for i=1:N
    P(i,4) = i ;
end
%
% find all interacting lattice neighbors and store in LE
%
k = 0 ;
P = sortrows(P, [1 2]) ;
for i=1:(N-1)
    if (P(i,1) == P(i+1,1)) & (P(i,2) == P(i+1,2))
        if (abs(P(i,3) - P(i+1,3)) == 1) & (abs(P(i,4) - P(i+1,4)) ~= 1)
            k = k + 1 ;
            LE(k,1) = P(i,4) ;
            LE(k,2) = P(i+1,4) ;
        end
    end
end
P = sortrows(P, [1 3]) ;
for i=1:(N-1)
    if (P(i,1) == P(i+1,1)) & (P(i,3) == P(i+1,3))
        if (abs(P(i,2) - P(i+1,2)) == 1) & (abs(P(i,4) - P(i+1,4)) ~= 1)
            k = k + 1 ;
            LE(k,1) = P(i,4) ;
            LE(k,2) = P(i+1,4) ;
        end
    end
end
P = sortrows(P, [2 3]) ;
for i=1:(N-1)
    if (P(i,2) == P(i+1,2)) & (P(i,3) == P(i+1,3))
        if (abs(P(i,1) - P(i+1,1)) == 1) & (abs(P(i,4) - P(i+1,4)) ~= 1)
            k = k + 1 ;
            LE(k,1) = P(i,4) ;
            LE(k,2) = P(i+1,4) ;
        end
    end
end
%
%  add up the interaction energies
%
Ew = 0 ;
for i=1:k
    Ew = Ew + E( SN(LE(i,1)) , SN(LE(i,2)) ) ;
end

