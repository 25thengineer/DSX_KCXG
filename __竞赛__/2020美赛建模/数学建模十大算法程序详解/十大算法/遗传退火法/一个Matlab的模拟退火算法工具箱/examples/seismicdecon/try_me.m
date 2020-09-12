function try_me
% Example SA Tools annealing for seismicdecon.
%
% NOTE: These are tests.  Values should not be taken as recommendations.
%
%
rand('state',1023) ;
%
verbose = 1 ;
%
newstate =  @decon_new ;
[X,TrueModel,noise] = decon_init ;
cost =      @decon_cost ;
moveclass = @decon_perturb ;
%
walkers =       12 ;
acceptrule =    @metropolis ;
q =             0 ;
% schedule =      @thermospeedHC ;
schedule =      @thermospeedR ;
P =             0 ;
equilibrate =   @hoffmann ;
C =             0.75 ;
maxsteps =      16 ;
Tinit =         @TinitAccept ;
r =             [0.99, 12] ;
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
%   plotBins(Ebin,rho,'E','rho','equilibrium density of states') ;
%   dispEh(Eh) ;
%
disp(['---------------------------------end---------------------------------']) ;
