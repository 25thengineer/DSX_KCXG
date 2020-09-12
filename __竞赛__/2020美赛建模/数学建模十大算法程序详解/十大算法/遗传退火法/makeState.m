function state = makeState(GenomeLength,FitnessFcn,options)
%MAKESTATE Create an initial population and fitness scores
%   state = makeStates(GenomeLength,FitnessFcn,options) Creates an initial
%   state structure using the information in the options structure.

%   Copyright 2003-2005 The MathWorks, Inc.
%   $Revision: 1.6.4.2 $  $Date: 2005/05/31 16:30:00 $

state.Population = gacreation_nn(GenomeLength,FitnessFcn,options);

if strcmpi(options.Vectorized, 'off')
    try
        state.Score = feval(@fcnvectorizer,state.Population,FitnessFcn,options.FitnessFcnArgs{:});
    catch
        error('gads:MAKESTATE:fitnessCheck', ...
            'GA cannot continue because user supplied fitness function failed with the following error:\n%s', lasterr)
    end
    if numel(state.Score) ~=size(state.Population,1)
        msg = sprintf('%s\n', ...
            'Your fitness function must return a scalar value.');
        error('gads:MAKESTATE:fitnessCheck',msg);
    end
else
    try
        state.Score = feval(FitnessFcn,state.Population,options.FitnessFcnArgs{:});
    catch
        error('gads:MAKESTATE:fitnessCheck', ...
            'GA cannot continue because user supplied fitness function failed with the following error:\n%s', lasterr)
    end
    if numel(state.Score) ~=size(state.Population,1)
        msg = sprintf('%s\n', ...
            ['When ''Vectorized'' is ''on'', your fitness function must ' ...
            'return a vector of length equal to the size of the population.']);
        error('gads:MAKESTATE:fitnessCheck',msg);
    end
end
state.FunEval = length(state.Score);          % number of function evaluations

% a variety of data used in various places
state.Generation = 0;		% current generation counter
state.StartTime = cputime;	% start time
state.StopFlag = []; 		% reason for termination
state.LastImprovement = 1;	% generation stall counter
state.LastImprovementTime = state.StartTime;	% time stall counter
state.Selection = [];       % selection indices
state.Expectation = [];     % expection of individuals
state.Best = [];            % best score in every generation
