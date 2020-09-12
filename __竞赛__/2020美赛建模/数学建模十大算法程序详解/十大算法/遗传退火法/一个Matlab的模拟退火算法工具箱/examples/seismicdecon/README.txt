README for seismicdecon example supplied with SA Tools.
                   
try_me.m            = example driver

decon_init.m      = produces a new problem and exposes solution

decon_new.m          = creates a trial solution
decon_perturb.m      = creates a neighbor of an existing trial solution
decon_cost.m         = computes 'energy' (fitness) of trial solution
modelsignal.m       = creates signal (time series) associated with trial solution

modelparts.m        = utility
eventparts.m        = utility

eventplot.m         = plots time series associated with problem
modelplot.m         = plots time series associated with trial solution


See http://www.frostconcepts.com/software for information on SA Tools.