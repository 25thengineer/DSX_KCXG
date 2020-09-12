function try_me
% Example SA Tools annealing for proteinfold.
%
% NOTE: These are tests.  Values should not be taken as recommendations.
%
%
rand('state',7315118063) ;
%
verbose = 1 ;
%
newstate =  @sequence_new ;
X =          sequence_init(7) ;
cost =      @sequence_cost ;
moveclass = @sequence_perturb ;
%
walkers =       16 ;
acceptrule =    @metropolis ;
q =             0 ;
schedule =      @hartley ;
P =             0.01 ;
equilibrate =   @hoffmann ;
C =             1.25 ;
maxsteps =      8 ;
Tinit =         @TinitT0 ;
r =             10000 ;
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
%    dispMat(Ebsf,'Ebsf','%6.2f') ;
%    Sequence = X{2}
%    [Emin, Eminloc] = min(Ebsf) 
%    W = Wbsf{Eminloc} ;
%    Edges = W{1} 
%    Positions = W{2} 
%
disp(['---------------------------------end---------------------------------']) ;
