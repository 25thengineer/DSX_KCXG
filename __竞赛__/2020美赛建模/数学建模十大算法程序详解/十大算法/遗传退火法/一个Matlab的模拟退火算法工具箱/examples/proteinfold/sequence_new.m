function W = sequence_new(X)
% W = sequence_new(X)
% Method for proteinfold example supplied with SA Tools.
% See http://www.frostconcepts.com/software for information on SA Tools.
%
%   W = sequence_new(X) ;
%
%   X = {N, S SN E}
%       N = length of sequence.
%       S = vector of letters representing sequence.
%       SN = vector of indicies representing sequence, isomorphic to S.
%       E = interaction energies.  E(SN(i),SN(j)) is the interaction energy of i, j.
%
%   W = {edge position} : an unfolded lattice sequence based on X.
%       edge = N-1 edge directions; e.g., edge(i) = [1, 0, 0]
%       position = N sequence element 3D lattice positions; e.g., position(1) = [0, 0, 0]
%
%   Instantiates the sequence of letters stored in X as a 3D lattice sequence.
%   Every realization produced by this routine has identical geometry: a straight line
%       beginning at the origin and continuing out along the x-axis ( [1,0,0] axis ).
%
N = X{1} ;
position(1,:) = [0, 0, 0] ;
for i=1:(N-1)
    edge(i,:) = [1, 0, 0] ;
    position(i+1,:) = position(i,:) + edge(i,:) ;
end
W = {edge position} ;
