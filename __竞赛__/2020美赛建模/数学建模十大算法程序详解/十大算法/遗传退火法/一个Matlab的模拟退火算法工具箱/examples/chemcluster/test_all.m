function test_all
% tests SA Tools annealing methods for chemcluster.
%
% NOTE: These are tests.  Values should not be taken as recommendations.
%
%
rand('state',61) ;
%
verbose = 1 ;
%
newstate =  @cluster_new ;
X =         cluster_init ;
cost =      @cluster_cost ;
moveclass = @cluster_perturb ;
%
scheds = 7 ;
sched =      [@geman, @geometric, @hartley, @berkeley, @thermospeedHC, @thermospeedR, @retrospect] ;
schedP =     { 50      0.9         0.005     0.1        0               0              [100, 10, 1] } ;
schedT0 =    [ Inf,    1000,       Inf,      100,       100,            100,            1000] ;
schedTf =    [ 0,      500,        -Inf,     0,         1,              2.9,              0] ;
schedV =     [ 0,      0,          0,        0,         0.2,            0.2,            0] ;
tempsteps =  [ 10,     10,         10,       10,        10,             15,             4] ;
%
bins = 10 ;
e = Inf ;
%
equils = 2 ;
equilib =    {0  @hoffmann} ;
equilibC =   [0, 2.5] ;
equilsteps = [5, 10] ;
%
t0methods = 2 ;
t0method = [@TinitWhite, @TinitAccept] ;
t0r =      { [0.5, 10]     [0.5, 10]} ;
%
tfmethods = 1 ;
tfmethod = [@TfinalNstop] ;
tff =      {[4, 1e-3]} ;
%
amethods = 5 ;
acceptmethod = [@metropolis, @szu, @tsallis, @threshold, @franz] ;
q =            [0,           0,    4,        0,          4] ;
%
walkertests = 2 ;
walkertest = [1, 5] ;
%
disp(['--------------------------------start--------------------------------']) ;
disp(['NOTE: These are tests.  Values should not be taken as recommendations.']) ;
%
for s=1:scheds
% for s=4:4
%
    for eq=1:equils
    % for eq=1:1
%
        for m=0:t0methods
        % for m=0:0
            if m == 0
                T0initmethod = schedT0(s) ;
                T0initconst = 0 ;
            else
                T0initmethod = t0method(m) ;
                T0initconst = t0r{m} ;
            end
%
            for am = 1:amethods
            % for am = 2:2
%
                for walkerc = 1:walkertests
                % for walkerc = 2:2
%
                    for z=0:tfmethods
                    % for z=1:1
                        if z == 0
                            Tfinalmethod = schedTf(s) ;
                            Tfinalconst = 0 ;
                        else
                            Tfinalmethod = tfmethod(z) ;
                            Tfinalconst = tff{z} ;
                        end
%
                        [W,Ew,Wbsf,Ebsf,Tt,Et,Etarget,ert,Kt,Ebsft,Eh,M,rho,Ebin] = ...
                            anneal(verbose, ...
                                newstate, X, ...
                                cost, moveclass, ...
                                walkertest(walkerc), ...
                                acceptmethod(am),q(am), ...
                                sched(s), schedP{s}, ...
                                equilib{eq}, equilibC(eq), equilsteps(eq), ...
                                T0initmethod, T0initconst, ...
                                Tfinalmethod, Tfinalconst, tempsteps(s), ...
                                schedV(s), bins, e) ;
%
%                       dispEh(Eh) ;
%                       dispEt(Tt,Et,Etarget,ert,Kt,Ebsft) ;
                        dispMat(rho,'rho','%6.2f') ;
                        dispMat(Ebin,'Ebin','%6.2f') ;
%                       plotBins(Ebin,rho,'E','rho','equilibrium density of states') ;
%
                    end
%
                end
%
            end
%
%
            clear W Ew Wbsf Ebsf Tt Et Etarget ert Kt Ebsft Eh M rho Ebin ;
%
        end
    end
end
%
disp(['---------------------------------end---------------------------------']) ;
