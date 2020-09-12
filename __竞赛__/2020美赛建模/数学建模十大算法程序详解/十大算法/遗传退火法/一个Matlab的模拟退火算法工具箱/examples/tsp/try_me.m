function try_me
% Example SA Tools annealing for tsp.
%
% NOTE: These are tests.  Values should not be taken as recommendations.
%
%
rand('state',721508) ;
%
verbose = 1 ;
%
newstate =  @route_new ;
X =          route_init(12) ;
cost =      @route_cost ;
moveclass = @route_perturb ;
%
walkers =       16 ;
acceptrule =    @metropolis ;
q =             0 ;
schedule =      @thermospeedHC ;
% schedule =      @thermospeedR ;
P =             0 ;
equilibrate =   @hoffmann ;
C =             1 ;
maxsteps =      256 ;
Tinit =         @TinitWhite ;
r =             [2, 16] ;
Tfinal =        @TfinalNstop ;
f =             [4, 1e-3] ;
maxtemps =      20 ;
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
    N = X{1} ;
    D = X{2} ;
    for i=1:N
        BSF(:,i) = Wbsf{i} ;
    end
    D
    BSF
    dispMat(Ebsf,'Ebsf','%6.2f') ;
%   plotBins(Ebin,rho,'E','rho','equilibrium density of states') ;
%   dispEh(Eh) ;
%
disp(['---------------------------------end---------------------------------']) ;
