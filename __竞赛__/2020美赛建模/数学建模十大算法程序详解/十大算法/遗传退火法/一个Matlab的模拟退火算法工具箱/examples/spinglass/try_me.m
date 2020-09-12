function try_me
% Example SA Tools annealing for spinglass.
%
% NOTE: These are tests.  Values should not be taken as recommendations.
%
%
rand('state',721508) ;
%
verbose = 1 ;
%
newstate =  @spin_new ;
[X, L] =    spin_init(3,5,4) ;
cost =      @spin_cost ;
moveclass = @spin_perturb ;
%
walkers =       16 ;
acceptrule =    @metropolis ;
q =             0 ;
schedule =      @thermospeedHC ;
% schedule =      @thermospeedR ;
P =             0 ;
equilibrate =   @hoffmann ;
C =             1 ;
maxsteps =      16 ;
Tinit =         @TinitWhite ;
r =             [3, 16] ;
Tfinal =        @TfinalNstop ;
f =             [4, 1e-3] ;
maxtemps =      10 ;
v =             0.2 ;
bins =          10 ;
e =             Inf ;
%
disp(['--------------------------------start--------------------------------']) ;
disp(['NOTE: These are tests.  Values should not be taken as recommendations.']) ;
%
%
    [W,Ew,Wbsf,Ebsf,Tt,Et,Etarget,ert,Kt,Ebsft,Eh,M,rho,Ebin] = ...
        anneal(verbose, ...
            newstate, X, ...
            cost, moveclass, ...
            walkers, ...
            acceptrule,q, ...
            schedule, P, ...
            equilibrate, C, maxsteps, ...
            Tinit, r, ...
            Tfinal, f, maxtemps, ...
            v, bins, e) ;
%
    dispMat(rho,'rho','%6.2f') ;
    dispMat(Ebin,'Ebin','%6.2f') ;
    dispMat(Ebsf,'Ebsf') ;
    % [Y, I] = min(Ebsf) ;
    % Wmin = W{I} ;
    % dispMat(Wmin,'Wmin') ;
%   plotBins(Ebin,rho,'E','rho','equilibrium density of states') ;
%   dispEh(Eh) ;
%
disp(['---------------------------------end---------------------------------']) ;
