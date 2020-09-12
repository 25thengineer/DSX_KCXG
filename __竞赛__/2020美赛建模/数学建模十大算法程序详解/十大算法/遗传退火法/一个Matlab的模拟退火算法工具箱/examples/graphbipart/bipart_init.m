function X = bipart_init(N)
% X = bipart_init(N)
% Method for graphbipart example supplied with SA Tools.
% See http://www.frostconcepts.com/software for information on SA Tools.
%
%   X = bipart_init(N) ;
%
%   N = # of vertices.  must be positive integer.
%   X = {N, A}
%       N = # of vertices.
%       A = Adjacency matrix
%
N = floor(N) ;
if N < 1
    error(sprintf('N must be positive.  was: %g', N)) ; 
end
%
%   A graph will be created as follows:
%       1. produce a simple cycle of N verticies
%       2. create additional edges between verticies on the cycle
%       3. the same graph will be created every time for each N.
%
%   Create the cycle:
%
C = 1:N ;
S = rand('state') ;           % save the current state of the random number generator
rand('state',17) ;            % use this fixed state instead
for k=1:N
    i = 1 + floor(rand*N) ;
    j = 1 + floor(rand*N) ;
    tmp = C(i) ;
    C(i) = C(j) ;
    C(j) = tmp ;
end
rand('state',S) ;             % return to previous random number sequence
C(N+1) = C(1) ;
%
%    Record the cycle in an adjacency matrix (math, not CS variety).
%
A(1:N,1:N) = 0 ;
for k=1:N
    i = C(k) ;
    j = C(k+1) ;
    A(i,j) = 1 ;
    A(j,i) = 1 ;
end
%
%   Create additional edges and store in adjacency matrix
%
S = rand('state') ;           % save the current state of the random number generator
rand('state',71+N) ;          % use this fixed state instead
for k=1:N
    i = 1 + floor(rand*N) ;
    j = 1 + floor(rand*N) ;
    if i ~= j
        from = C(i) ;
        to = C(j) ;
        A(from,to) = 1 ;
        A(to,from) = 1 ;
    end
end
rand('state',S) ;             % return to previous random number sequence
%
X = {N A} ;
