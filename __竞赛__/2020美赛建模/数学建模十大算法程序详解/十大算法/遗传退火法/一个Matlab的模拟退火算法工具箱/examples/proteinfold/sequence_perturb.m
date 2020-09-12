function W = sequence_perturb(X,W,Ea,T)
% W = sequence_perturb(X,W,Ea,T)
% Method for proteinfold example supplied with SA Tools.
% See http://www.frostconcepts.com/software for information on SA Tools.
%
%   W = sequence_perturb(X,W,Ea,T) ;
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
%   Ea = (not used) current average energy
%   T = (not used) current temperature
%
%   Picks an edge between two verticies in the lattice sequence and changes its
%       direction, keeping the remaining part of the sequence attached and intact.
%       The result is a non-axial rotation of the sequence about the starting
%       vertex of the edge.
%   Checks to make sure the new path is not self-intersecting.
%
N = X{1} ;
G = W{1} ;
P = W{2} ;
%
%   Assume new edge will not be valid
%
notvalid = 1 ;
while notvalid
    q = ceil((N-1)*rand) ;      % pick an edge
    Gq = G(q,:) ;               % save it, in case the new one is not valid
    c = ceil(3*rand) ;          % pick a lattice axis for the new edge
    if rand < 0.5               % pick a lattice direction along the axis
        v = -1 ;
    else
        v = 1 ;
    end
    for i=1:(c-1)               % initialize the new coordinate
        G(q,i) = 0 ;
    end
        G(q,c) = v ;
    for i=(c+1):3
        G(q,i) = 0 ;
    end
    for i=1:(N-1)               % create a list of vertex coordinates
        P(i+1,:) = P(i,:) + G(i,:) ;
    end
    notvalid = 0 ;
    PS = sortrows(P) ;              % sort the list of coordinates
    for i=1:(N-1)                   % look for duplications
        if PS(i,:) == PS(i+1,:)     % if the new edge is invalid, put back the old one.
            notvalid = 1 ;
            G(q,:) = Gq ;
            break ;
        end
    end
end                                 % loop until valid edge is found
%
W = {G P} ;
