function a = franz(dE,T,q)
% Franz acceptance method supplied with SA Tools.
% Copyright (c) 2002, by Richard Frost and Frost Concepts.
% See http://www.frostconcepts.com/software for information on SA Tools.
%
%   a = franz(dE,T,q) ;
%
%   dE = the difference in cost between a trial state and
%     the current state: dE = Wtrial - W
%   T = the current temperature
%   q = the "q" parameter of the franz acceptance rule
%   a = 0 if trial is rejected, otherwise 1.
%
a = 0 ;
if dE <= 0                           % accept non-uphill moves
    a = 1 ;
elseif (q == 1) | (q == 2)           % avoid division by 0
    a = 1 ;
else
    if T > 0            % ignore 0 or negative temperatures
        D = ((1 - q)/(2 - q))*(dE/T) ;
        if D <= 1
            if rand < (1 - D)^(1/(1-q))
                a = 1 ;
            end
        end
    end
end
