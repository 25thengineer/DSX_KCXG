function [W,Ew,Wbsf,Ebsf,Tt,Et,Etarget,ert,Kt,Ebsft,Eh,M,rho,Ebin] = anneal( ...
    verbose, ...
    newstate, X, ...
    cost, moveclass, ...
    walkers, ...
    acceptrule, q, ...
    schedule, P, ...
    equilibrate, C, maxsteps, ...
    Tinit, r, ...
    Tfinal, f, maxtemps, ...
    v, bins, e)
% MAIN DRIVER and HELP file supplied with SA Tools.
% Copyright (c) 2002, by Richard Frost and Frost Concepts.
% See http://www.frostconcepts.com/software for information on SA Tools.
% Get the book:  http://www.frostconcepts.com/books/ebsa/
%
% [W,Ew,Wbsf,Ebsf,Tt,Et,Etarget,ert,Kt,Ebsft,Eh,M,rho,Ebin] = anneal( ...
%     verbose, ...
%     newstate, X, ...
%     cost, moveclass, ...
%     walkers, ...
%     acceptrule, q, ...
%     schedule, P, ...
%     equilibrate, C, maxsteps, ...
%     Tinit, r, ...
%     Tfinal, f, maxtemps, ...
%     v, bins, e)
%
%   verbose = prints status information when true (1).
%   newstate = (handle to) user-defined method
%           W0 = newstate(X)    where
%               X = user-defined problem domain or other data,
%                       behaviorally static.
%               W0 = an initial user-defined state.
%           Book chapter 2.
%   X = user-defined problem domain or other data, behaviorally static.
%           Book chapter 2.
%   cost = (handle to) user-defined objective method (function)
%           Ew = cost(X,W)    where
%               X = user-defined problem domain or other data.
%               W = a user-defined state from 'newstate' or 'moveclass'.
%               Ew = energy corresponding to W
%           Book chapter 9.
%   moveclass = (handle to) user-defined method,
%           W = moveclass(X,W,Ea,T)    where
%               X = user-defined problem domain or other data.
%               W = a user-defined state from 'newstate' or 'moveclass'.
%               Ea = average energy at current temperature.
%               T = current temperature
%           Book chapters 2.2 and 10.2.
%   walkers = number of walkers.  Must be positive integer.
%               walkers = 1 implies barebones annealing
%               walkers > 4 suggested for ensemble methods
%           Book chapters 4 and 7.
%   acceptrule = (handle to) SA Tools or user-defined method
%           a = acceptrule(dE,T,q)    where
%               dE = the difference in cost between a trial state and
%                       the current state: dE = Wtrial - W
%               T = the current temperature
%               q = any data required by the acceptrule
%               a = 0 if trial is rejected, otherwise 1.
%           SA Tools supplied methods are:
%               metropolis
%               szu
%               tsallis
%               threshold
%               franz
%           Book chapter 11.    
%   q = any data required by the acceptrule.
%           Book chapter 11.
%   schedule = (handle to) SA Tools or user-defined temperature update
%           nextT = schedule(Ea,Estd,walkers,dEtgt,v,e,T,t,P)    where
%               Ea = average energy at current temperature.
%               Estd = standard deviation of energies
%               dEtgt = difference between present and previous target mean energy
%               walkers = number of walkers.  Must be positive integer.
%               T = current temperature
%               i = # of current temperature
%                   (i.e., 1st temperature is 1, 2nd is 2, etc.)
%               P = any data required by schedule
%               nextT = next temperature
%           SA Tools supplied methods are:
%               geman
%               geometric
%               hartley
%               berkeley
%               thermospeedHC
%               thermospeedR
%               retrospect
%           Book chapter 13.
%   P = any data required by schedule.
%   equilibrate = (handle to) SA Tools method, or user-defined method,
%           or a non-function_handle type (e.g., 0).  If a function handle is 
%           supplied, then the temperature will not change (i.e., schedule will
%           not be called) until equilibrate returns false (0).  Otherwise, the
%           moveclass will be executed maxsteps times between each
%           temperature change.  Method signature:
%               b = equilibrate(Ea0,Ea,Ew,walkers,T,step,maxsteps,C)    where
%                   Ea0 = average energy at the beginning of the metropolis walk
%                   Ea = current average energy
%                   Ew = current energies corresponding to W (size walkers)
%                   walkers = the number of walkers in the simulation
%                   T = the current temperature
%                   step = the current number of steps taken in the walk
%                   maxsteps = an upper limit on the number of steps in the walk
%                   C = any behaviorally constant data required by the method
%                   b = 0 if the temperature may change, otherwise 1.
%               SA Tools supplied methods are:
%                   hoffmann    (wait-for-a-fluctuation)
%           Book chapter 13.
%   C = any data required by equilibrate.
%   maxsteps = maximum number of times to attempt equilibration (call moveclass at fixed T).
%           Book chapter 13.
%   Tinit = initial temperature (Inf ok) -- or (handle to) SA Tools method,
%           or user-defined method.  If method handle is not present, then the
%           initial temperature will be T0 = Tinit.  Otherwise, the method will
%           calculate T0.  All moves made during this method must be accepted.
%           Method signature:
%               [T0,W,Ew,Ev,steps] = Tinit(r, walkers, newstate, X, cost, moveclass)
%                   INPUTS:
%                       r = behaviorially constant data required by Tinit (if any)
%                       walkers, newstate, X, cost, moveclass: defined above
%                   OUTPUTS:
%                       T0 = initial temperature
%                       steps = # of steps taken by each walker during Tinit
%                       Ev = energy (cost) history at T (infinite for Tinit)
%                           i = arbitrary index
%                           Ev(i,1) = step #
%                           Ev(i,2) = walker #
%                           Ev(i,3) = an energy visited during T
%                           Ev(i,4) = energy attempted from Ev(i,1:3) during T
%                       W,Ew: defined below
%               SA Tools supplied methods are:
%                   TinitT0
%                   TinitAccept
%                   TinitWhite
%           Book section 13.1.
%   r = behaviorially constant data required by Tinit (if any)
%           Book section 13.1.
%   Tfinal = final temperature (-Inf ok) or (handle to) SA Tools method,
%           or user-defined method.  If method handle is not present, then the
%           simulation will end when T drops below the value of Tfinal.
%           Otherwise, the method will calculate a logical value which when
%           true (equal to 1) will stop the simulation.
%           Method signature:
%               b = Tfinal(W,Ew,t,Tt,Et,Etarget,ert,Kt,Ebsft,f)
%                   INPUTS:
%                       W = cell array of current states (size walkers)
%                       Ew = energies associated with W
%                       t = current temperature step index; i.e., current T = Tt(t).
%                       Tt = temperature history of simulation (so far)
%                       Et = mean energy history
%                       Etarget = target mean energy history
%                       ert = relaxation time history
%                       Kt = equilibrium step history
%                       Ebsft = Ebsf history
%                       f = behaviorally constant data required by Tfinal method
%                   OUTPUT:
%                       b = true (equal to 1) when final temperature iteration has been reached
%               SA Tools supplied methods are:
%                   TfinalNstep
%           Book section 13.1.
%   f = behaviorally constant data required by Tfinal method
%           Book section 13.1.
%   maxtemps = maximum number of temperature iterations.
%           Book chapter 13.
%   v = thermodynamic speed.
%               Effects thermospeed schedules.
%               Typically 0 < v < 1.  0 ok for non-thermospeed schedules.
%           Book chapter 13.
%   bins = # of bins to use in estimation of M, e, rho, and Ebin each temperature step.
%               If bins <= 0, then M, e, rho, and Ebin will not be calculated
%                   and the user-supplied constant value of e will be used each step.
%               If bins > 0, then the supplied value of e will be ignored and
%                   the TM method will be called to calculate M, e, rho, and Ebin.
%           Book section 12.2.1.
%   e = estimate of relaxation time.  See bins, above.
%           Book section 12.2.1.
%
%   RETURN VALUES:
%   W = cell array of final state(s) of size 'walkers'
%   Ew = array of final energies corresponding to W
%   Wbsf = array of best-so-far states of size 'walkers'
%   Ebsf = array of best-so-far energies
%   Tt(i) = temperature at temperature step i-1
%       NOTE: matlab does not permit indicies less than 1,
%               so step 0 is at i=1, etc.
%   Et(i) = average energy at Tt(i)
%   Etarget(i) = target mean energy at Tt(i), calculated with v.
%   ert(i) = estimated relaxation time at Tt(i), calculated with bins.
%   Kt(i) = number of equilibration steps taken at Tt(i)
%   Ebsft(i) = best-so-far energy at Tt(i)
%   Eh = energy and temperature history
%          i = 1, 1+(steps*walkers), etc.
%          Eh(i,1) = index t of temperature step
%          Eh(i,2) = T corresponding to t
%          Eh(i,3) = equilibrium step #j at T
%          Eh(i,4) = walker #k
%          Eh(i,5) = energy E visited by walker k at step j during T
%          Eh(i,6) = energy E' attempted from E by walker k at step j during T
%   M = final Transition Matrix (see book section 12.2.1).
%   rho = final estimate of equilibrium density of states
%   Ebin = energy bin centroids, min, and max
%          Ebin(1,:) are bin centroids.  Ebin(1,b) is the centroid for rho(b).
%          Ebin(2,:) are bin lower bounds
%          Ebin(3,:) are bin upper bounds
%
% Example uses of this driver can be found in the examples/ directory.
%
%   e.g.,
%
%   rand('state',sum(100*clock)) ;
%   [W,Ew,Wbsf,Ebsf,Tt,Et,Etarget,ert,Kt,Ebsft,Eh,M,rho,Ebin] = anneal( ...
%       1, ...
%       12, ...
%       @mystate, mydomain, ...
%       @mycost, @myneighbor, ...
%       @metropolis, [], ...
%       @thermospeed, 0, ...
%       @hoffman, 0.75, 20, ...
%       @TinitWhite, [1.7, 3], ...
%       1, 0, 50, ...
%       0.3, 10, 0) ;
%
error(nargchk(21,21,nargin)) ;
%
% Check for valid input
%
if ~isa(newstate, 'function_handle')
    error('No function handle supplied for newstate') ;
end
classX = class(X) ;
sizeX = size(X) ;
if ~isa(cost, 'function_handle')
    error('No function handle supplied for cost') ;
end
if walkers < 1
    error('Number of walkers must be positive') ;
end
if ~isa(acceptrule, 'function_handle')
    error('No function handle supplied for acceptrule') ;
end
classQ = class(q) ;
sizeQ = size(q) ;
if ~isa(schedule, 'function_handle')
    error('No function handle supplied for schedule') ;
end
classP = class(P) ;
sizeP = size(P) ;
if isa(equilibrate, 'function_handle')
    hasEquilibrate = 1 ;
else
    hasEquilibrate = 0 ;
end
classC = class(C) ;
sizeC = size(C) ;
if maxsteps < 1
    error('maxsteps must be positive') ;
end
if isa(Tinit, 'function_handle')
    hasTinitMethod = 1 ;
else
    if ~isa(Tinit, 'numeric')
      error('No numeric value or function handle supplied for Tinit') ;
    end
    hasTinitMethod = 0 ;
end
if ~isa(r, 'numeric')
    error('No numeric value supplied for r') ;
end
if isa(Tfinal, 'function_handle')
    hasTfinalMethod = 1 ;
else
    if ~isa(Tfinal, 'numeric')
      error('No numeric value or function handle supplied for Tfinal') ;
    end
    hasTfinalMethod = 0 ;
end
if ~isa(f, 'numeric')
    error('No numeric value supplied for f') ;
end
if maxtemps < 1
    error('maxtemps must be positive') ;
end
if ~isa(v, 'numeric')
    error('No numeric value supplied for v') ;
end
if ~isa(bins, 'numeric')
    error('No numeric value supplied for bins') ;
end
if ~isa(e, 'numeric')
    error('No numeric value supplied for e') ;
end
%
%
if verbose
    newline = sprintf('\n') ;
    tab = sprintf('\t') ;
    [vnum, vdate] = satoolsversion ;
    disp(['SA Tools anneal. Version ', vnum, ', Last update ', vdate, '.', newline]) ;
    disp([tab, 'newstate = ', func2str(newstate)]) ;
    disp([tab, 'X is ', classX, ' of size ', num2str(sizeX)]) ;
    disp([tab, 'cost = ', func2str(cost)]) ;
    disp([tab, 'moveclass = ', func2str(moveclass)]) ;
    disp([tab, 'walkers = ', num2str(walkers)]) ;
    disp([tab, 'acceptrule = ', func2str(acceptrule)]) ;
    disp([tab, 'q = ', num2str(q)]) ;
    disp([tab, 'schedule = ', func2str(schedule)]) ;
    disp([tab, 'P = ', num2str(P)]) ;
    if hasEquilibrate
        disp([tab, 'equilibrate = ', func2str(equilibrate)]) ;
    else
        disp([tab, 'equilibrate = (none)']) ;
    end
    disp([tab, 'C = ', num2str(C)]) ;
    disp([tab, 'maxsteps = ', num2str(maxsteps)]) ;
    if hasTinitMethod
        disp([tab, 'Tinit = ', func2str(Tinit)]) ;
    else
        disp([tab, 'Tinit = ', num2str(Tinit)]) ;
    end
    disp([tab, 'r = ', num2str(r)]) ;
    if hasTfinalMethod
        disp([tab, 'Tfinal = ', func2str(Tfinal)]) ;
    else
        disp([tab, 'Tfinal = ', num2str(Tfinal)]) ;
    end
    disp([tab, 'f = ', num2str(f)]) ;
    disp([tab, 'maxtemps = ', num2str(maxtemps)]) ;
    disp([tab, 'v = ', num2str(v)]) ;
    disp([tab, 'bins = ', num2str(bins)]) ;
    disp([tab, 'e = ', num2str(e), newline]) ;
end
%
% Perform temperature initialization (temperature step 0).
%
if hasTinitMethod
    [T,W,Ew,Wbsf,Ebsf,Ea,Ev,steps] = feval(Tinit,r, walkers, newstate, X, cost, moveclass) ;
else
    [T,W,Ew,Wbsf,Ebsf,Ea,Ev,steps] = TinitT0(Tinit, walkers, newstate, X, cost, moveclass) ;
end
%
% Initialize counters, histories, etc.
% Note: Matlab matrix indicies run from 1 to whatever.
%   Consequently, temperature steps 0 to maxsteps are
%   internally indexed from 1 to maxsteps+1.
%
Eh = historyupdate([],Ev,0,Inf) ;
j = 1 ;
Tt(j) = Inf ;
Et(j) = Ea ;
Etarget(j) = Ea ;
ert(j) = 0 ;
Kt(j) = steps ;
Ebsft(j) = min(Ebsf) ;
%
if verbose
    disp(sprintf('%8s %10s %10s %10s %10s %10s %10s %10s %12s','t','T','<E>','Etarget', 'Estd','e','steps','Ebsf')) ;
    disp(sprintf('%8d %10.3g %10.3g %10.3g %10.3g %10.3g %10d %12.5g', ...
        round(j-1),Tt(j), Et(j), Etarget(j), std(Ew), ert(j), round(Kt(j)), Ebsft(j))) ;
end
%
% Iterature through the temperature steps
%
for i=1:maxtemps
    clear Ev ;
    %
    % Go take an equilibrium walk
    %
    [W,Ew,Wbsf,Ebsf,Ea,Estd,Ev,steps] = metropoliswalk( ...
        verbose, ...
        Ea, T, ...
        walkers, W, X, cost, moveclass, ...
        acceptrule, q, ...
        hasEquilibrate, equilibrate, C, maxsteps, ...
        Wbsf, Ebsf) ;
    %
    % Record what happenned
    %
    j = i+1 ;
    Tt(j) = T ;
    Et(j) = Ea ;
    Etarget(j) = Ea - (v*Estd) ;   % update the target on-the-fly
    Kt(j) = steps ;
    Ebsft(j) = min(Ebsf) ;
    Eh = historyupdate(Eh,Ev,i,T) ;  % update the history array
    %
    % Compute the density of states and relaxation time
    %
    if bins <= 0    % unless turned off
        M = [] ;
        rho = [] ;
        Ebin = [] ;
    else
        [M, e, rho, Ebin] = TM(Eh,bins) ;
    end
    ert(j) = e ;    % record the relaxation time
    %
    if verbose
        disp(sprintf('%8d %10.3g %10.3g %10.3g %10.3g %10.3g %10d %12.5g', ...
            round(j-1),Tt(j), Et(j), Etarget(j), Estd, ert(j), round(Kt(j)), Ebsft(j))) ;
    end
    %
    % Perform the temperature update.  Halt if some stopping criteria reached.
    %
    dEtgt = Etarget(j) - Etarget(j-1) ;
    T = feval(schedule,Ea,Estd,walkers,dEtgt,v,e,T,i,P) ;
    if hasTfinalMethod
        if feval(Tfinal,W,Ew,j,Tt,Et,Etarget,ert,Kt,Ebsft,f)
            if verbose
                disp(tab) ;
                disp([tab,'Stop criteria met for "',func2str(Tfinal),'"']) ;
            end
            break ;
        end
    elseif T < Tfinal
        if verbose
            disp(tab) ;
            disp([tab,'Tfinal (',num2str(Tfinal),') surpassed at T = ',num2str(T)]) ;
        end
        break ;
    end
end
if verbose
   disp(tab) ;
end
%
% Return data to caller.
%
