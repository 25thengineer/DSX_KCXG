function b = TfinalNstop(W,Ew,t,Tt,Et,Etarget,ert,Kt,Ebsft,f)
% Final temperature determination method supplied with SA Tools.
% Copyright (c) 2002, by Richard Frost and Frost Concepts.
% See http://www.frostconcepts.com/software for information on SA Tools.
%
%   b = TfinalNstop(W,Ew,t,Tt,Et,Etarget,ert,Kt,Ebsft,f) ;
%
%   INPUTS:
%       W = cell array of current states (size walkers)
%       Ew = energies associated with W
%       t = current temperature step index; i.e., current T = Tt(t).
%       Tt = temperature history of simulation (so far)
%       Et = mean energy history
%       Etarget = target mean energy history
%       ert = relaxation time history
%       Kt = equilibrium step history
%       Ebsft = Ebsf history
%       f = [N, relerr] ;
%   OUTPUT:
%       b = true (equal to 1) when the last N mean energies are equal to within relerr.
%
%       For i = (t+1-N) to t-1:   abs((Et(i) - Et(t))/Et(t)) <= relerr.
%
N = f(1) ;
relerr = f(2) ;
if (t < N) | (N < 1)
    b = 0 ;
elseif N == 1
    b = 1 ;
else
    b = 1 ;
    %
    % handle special cases of zero and infinite denominators
    %
    if abs(Et(t)) == Inf
        for i=(t+1-N):(t-1)
            if Et(i) ~= Et(t)
                b = 0 ;
                break ;
            end
        end
    elseif Et(t) == 0
        for i=(t+1-N):(t-1)
            if abs(Et(i)) > relerr
                b = 0 ;
                break ;
            end
        end
    else
        for i=(t+1-N):(t-1)
            if abs((Et(i) - Et(t))/Et(t)) > relerr
                b = 0 ;
                break ;
            end
        end
    end
end
