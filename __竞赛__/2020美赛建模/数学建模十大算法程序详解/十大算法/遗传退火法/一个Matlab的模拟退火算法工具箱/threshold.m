function a = threshold(dE,T,q)
% Threshold acceptance method supplied with SA Tools.
% Copyright (c) 2002, by Richard Frost and Frost Concepts.
% See http://www.frostconcepts.com/software for information on SA Tools.
%
%   a = threshold(dE,T,q) ;
%
%   dE = the difference in cost between a trial state and
%     the current state: dE = Wtrial - W
%   T = the current temperature.  Must be positive.
%   q = (not used) the "q" parameter of the acceptance rule
%   a = 0 if trial is rejected, otherwise 1.
%
if (T > 0) & (dE <= T)
    a = 1 ;
else
    a = 0 ;
end
