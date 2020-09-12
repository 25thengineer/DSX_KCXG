function X = sequence_init(N)
% X = sequence_init(N)
% Method for proteinfold example supplied with SA Tools.
% See http://www.frostconcepts.com/software for information on SA Tools.
%
%   X = sequence_init(N) ;
%
%   N = length of sequence.  must be integer >= 7.
%   X = {N, S SN E}
%       N = length of sequence.
%       S = vector of letters representing sequence.
%       SN = vector of indicies representing sequence, isomorphic to S.
%       E = interaction energies.  E(SN(i),SN(j)) is the interaction energy of i, j.
%
%   Initializes a 2-letter sequence S of length N.
%   Produces an integer representation SN of S.
%       A in S  is  1 in SN
%       B in S  is  2 in SN
%   Produces matrix E of interaction energies.
%
%   For each N, the same S, SN, and E are produced.
%
Nin = N ;
N = floor(Nin) ;
if N < 7
    error(sprintf('N must be >= 7.  was: %g', Nin)) ; 
end
%
%  Initialize the core sequence of 7.  Identical to example in book.
%
S =  [ 'B', 'A', 'A', 'B', 'B', 'A', 'B' ] ;
SN = [   2,   1,   1,   2,   2,   1,   2 ] ;
%
%  If requested N was larger, add more to sequence
%
savestate = rand('state') ;     % save the current state of the random number generator
rand('state',2112212) ;         % use this state instead
for i=8:N
    if rand < 0.5
        S(i) = 'A' ;
        SN(i) = 1 ;
    else
        S(i) = 'B' ;
        SN(i) = 2 ;
    end
end
rand('state',savestate) ;       % return to previous random number state
%
%  Set the interaction matrix.  Same as in book.
%
E(1,1) = 1 ;
E(1,2) = -2 ;
E(2,1) = E(1,2) ;
E(2,2) = 2 ;
%
X = {N S SN E} ;
