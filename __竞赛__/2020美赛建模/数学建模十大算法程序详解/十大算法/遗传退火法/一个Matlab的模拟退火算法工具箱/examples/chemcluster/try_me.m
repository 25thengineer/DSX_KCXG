function try_me
% Example SA Tools annealing for chemcluster.
%
% NOTE: These are tests.  Values should not be taken as recommendations.
%
%
rand('state',sum(100*clock)) ;
%
verbose = 1 ;
%
newstate =  @cluster_new ;
X =         cluster_init(13) ;
cost =      @cluster_cost ;
moveclass = @cluster_perturb ;
%
walkers =       16 ;
acceptrule =    @metropolis ;
q =             0 ;
% schedule =      @thermospeedHC ;
schedule =      @thermospeedR ;
P =             0 ;
equilibrate =   @hoffmann ;
C =             1.75 ;
maxsteps =      32 ;
Tinit =         @TinitAccept ;
r =             [0.75, 32] ;
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
    % [Y,I] = min(Ebsf) ;
    % Wmin = W{I} ;
    % clusterplot(Wmin) ;
%   plotBins(Ebin,rho,'E','rho','equilibrium density of states') ;
%   dispEh(Eh) ;
%
disp(['---------------------------------end---------------------------------']) ;
