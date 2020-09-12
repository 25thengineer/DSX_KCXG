function [M,e,rho,Ebin] = TM(Eh,bins)
% Transition matrix calculation method supplied with SA Tools.
% Copyright (c) 2002, by Richard Frost and Frost Concepts.
% See http://www.frostconcepts.com/software for information on SA Tools.
%
%   [M,e,rho] = TM(Eh) ;
%
%   INPUT:
%   Eh = energy and temperature history
%          i = 1, 1+(steps*walkers), etc.
%          Eh(i,1) = index t of temperature step
%          Eh(i,2) = T corresponding to t
%          Eh(i,3) = equilibrium step #j at T
%          Eh(i,4) = walker #k
%          Eh(i,5) = energy E visited by walker k at step j during T
%          Eh(i,6) = energy E' attempted from E by walker k at step j during T
%
%   OUTPUT:
%   M = Transition Matrix (see book section 12.2.1).
%   e = estimate of relaxation time
%   rho = estimate of equilibrium density of states
%   Ebin = energy bin centroids, min, and max
%           Ebin(1,:) are bin centroids.  Ebin(1,b) is the centroid for rho(b).
%           Ebin(2,:) are bin lower bounds
%           Ebin(3,:) are bin upper bounds
%
M = [] ;
e = 0 ;
rho = [] ;
%
% get the energies of visited (Ej) and neighbor (Ei) states
%
Ej = Eh(:,5)' ;
Ei = Eh(:,6)' ;
%
%  Create a sorted, unique list of all energies, E.
%  k will be the number of unique energies.
%
A = sort(cat(2,Ej,Ei)) ;
L = numel(A) ;
k = 1 ;
E(k) = A(1) ;
for i=2:L
    if A(i) ~= E(k)
        k = k + 1 ;
        E(k) = A(i) ;
    end
end
%
%  Need to have an energy for each bin.
%  Create phony out-of-range energies for any remaining bins.
%
if k < bins
    offset = (max(E) - min(E)) / bins ;
    for i=(k+1):bins
        E(i) = E(i-1) + offset ;
    end
    fullbins = k ;
    k = bins ;
else
    fullbins = bins ;
end
%
%  Create partition locations within E for the bins
%
if k == bins
    for b=1:(bins-1)
        Part(b) = b + 1 ;
    end
else
    m = k / bins ;
    for b=1:(bins-1)
        Part(b) = ceil(b*m) ;
    end
end
Part(bins) = k ;
%
%  Find separation values for each bin
%
for b=1:(bins-1)
    Epart(b) = 0.5*((E(Part(b)-1)) + E(Part(b))) ;
end
Epart(bins) = E(k) ;
%
%  Find # values in each bin and compute sum of values for centroid computation.
%
Esum(1:bins) = 0 ;
Ecount(1:bins) = 0 ;
for i=1:L
    for b=1:bins
        if A(i) <= Epart(b)
            Esum(b) = Esum(b) + A(i) ;
            Ecount(b) = Ecount(b) + 1 ;
            break ;
        end
    end
end
%
%  Compute centroid
%
for b=1:fullbins                                    % real bins
        Ebin(1,b) = Esum(b) / Ecount(b) ;
end
for b=(fullbins+1):bins                             % phony bins
        Ebin(1,b) = 0.5 * (Epart(b-1) + Epart(b)) ;
end
%
%  Compute the min and max for the bins
%
Ebin(2,1) = E(1) ;
Ebin(3,1) = Epart(1) ;
for b=2:bins
    Ebin(2,b) = Epart(b-1) ;
    Ebin(3,b) = Epart(b) ;
end
clear A E Part ;
%
%  Q matrix computation
%
Q(1:bins,1:bins) = 0 ;
L = numel(Ej) ;
for k=1:L
    for b=1:bins
        if Ej(k) <= Epart(b)
            j = b ;
            break ;
        end
    end
    for b=1:bins
        if Ei(k) <= Epart(b)
            i = b ;
            break ;
        end
    end
    Q(i,j) = Q(i,j) + 1 ;
end
%
%  P matrix computation
%
for j=1:bins
    Qjsum(j) = 0 ;
    for i=1:bins
        Qjsum(j) = Qjsum(j) + Q(i,j) ;
    end
end
for i=1:bins
    for j=1:bins
        if Qjsum(j) == 0
            P(i,j) = 0 ;
        else
            P(i,j) = Q(i,j) / Qjsum(j) ;
        end
    end
end
%
%  Infinite temperature density of states estimation
%
[V,D] = eig(P) ;
D = abs(D) ;
maxe = D(1,1) ;
maxel = 1 ;
for b=2:bins
    if D(b,b) > maxe
        maxe = D(b,b) ;
        maxel = b ;
    end
end
principal(1:bins) = V(1:bins,maxel) ;
rho = principal/sum(principal) ;
clear V D ;
%
%  Boltzmannized matrix computation
%
[Ehrows, Ehcols] = size(Eh) ;
T = Eh(Ehrows,2) ;
M(1:bins,1:bins) = 0 ;
for i=1:bins
    for j=1:bins
        if i ~= j
            if Ebin(1,i) <= Ebin(1,j)
                M(i,j) = P(i,j) ;
            else
                M(i,j) = P(i,j)*exp((Ebin(1,j) - Ebin(1,i))/T) ;
            end
        end
    end
end
for i=1:bins
    d = 1 - sum(M(:,i)) ;
    M(i,i) = d ;
end
clear P ;
%
%  Relaxation time estimation
%
[V,D] = eig(M) ;
lambda = sort(abs(diag(D))) ;       % sorted eigenvalue magnitudes
maxlambda = lambda(bins) ;
b = bins - 1 ;
while (b > 0)
    if lambda(b) == maxlambda
        b = b - 1 ;
    else
        break ;
    end
end
if b == 0
    e = Inf ;
elseif lambda(b) == 0
    e = 0 ;
else
    loglambda2 = log(lambda(b)) ;
    if loglambda2 >= 0
        e = Inf ;
    else
        e = -1 / loglambda2 ;
    end
end
