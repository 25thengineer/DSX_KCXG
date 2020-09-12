function a = tsallis(dE,T,q)
% Tsallis acceptance method supplied with SA Tools.
% Copyright (c) 2002, by Richard Frost and Frost Concepts.
% See http://www.frostconcepts.com/software for information on SA Tools.
%
%   a = tsallis(dE,T,q) ;
%
%   dE = the difference in cost between a trial state and
%     the current state: dE = Wtrial - W
%   T = the current temperature
%   q = the "q" parameter of the tsallis acceptance rule
%   a = 0 if trial is rejected, otherwise 1.
%
a = 0 ;
if T > 0
    if (dE <= 0) | (q == 1)
        a = 1 ;
    else
        D = (1 - q)*(dE/T) ;
        if D <= 1
            if rand < (1 - D)^(1/(1-q))
                a = 1 ;
            end
        end
    end
end
