function a = metropolis(dE,T,q)
% Metropolis acceptance method supplied with SA Tools.
% Copyright (c) 2002, by Richard Frost and Frost Concepts.
% See http://www.frostconcepts.com/software for information on SA Tools.
%
%   a = metropolis(dE,T,q) ;
%
%   dE = the difference in cost between a trial state and
%     the current state: dE = Wtrial - W
%   T = the current temperature
%   q = (not used) any data required by the acceptrule
%   a = 0 if trial is rejected, otherwise 1.
%
a = 0 ;
if (dE <= 0)
    a = 1 ;
else
    if rand < exp(-dE/T)
        a = 1 ;
    end
end
