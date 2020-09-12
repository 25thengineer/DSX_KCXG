function [nextScore,nextPopulation,state] = stepGA(thisScore,thisPopulation,options,state,GenomeLength,FitnessFcn)
%STEPGA Moves the genetic algorithm forward by one generation
%   This function is private to GA.

%   Copyright 2003-2005 The MathWorks, Inc.
%   $Revision: 1.8.4.2 $  $Date: 2005/05/31 16:30:24 $

% how many crossover offspring will there be from each source?
nPop = size(thisPopulation,1);
nEliteKids = options.EliteCount;
nXoverKids = round(options.CrossoverFraction * (nPop - nEliteKids));
nMutateKids = nPop - nEliteKids - nXoverKids;
% how many parents will we need to complete the population?
nParents = 2 * nXoverKids + nMutateKids;

[unused,k] = sort(thisScore);
eliteKids  = thisPopulation(k(1:nEliteKids),:);

% decide who will contribute to the next generation
% fitness scaling
state.Expectation = feval(options.FitnessScalingFcn,thisScore,nParents,options.FitnessScalingFcnArgs{:});

% selection. parents are indicies into thispopulation
parents = feval(options.SelectionFcn,state.Expectation,nParents,options,options.SelectionFcnArgs{:});

% shuffle to prevent locality effects. It is not the responsibility
% if the selection function to return parents in a "good" order so
% we make sure there is a random order here.
parents = parents(randperm(length(parents)));
%parents = randperm(nParents);

% Everyones parents are stored here for genealogy display
state.Selection = [1:nEliteKids,parents]';

% here we make all of the members of the next generation
xoverKids  = feval(options.CrossoverFcn, parents(1:(2 * nXoverKids)),options,GenomeLength,FitnessFcn,thisScore,thisPopulation,options.CrossoverFcnArgs{:});
mutateKids = feval(options.MutationFcn,  parents((1 + 2 * nXoverKids):end), options,GenomeLength,FitnessFcn,state,thisScore,thisPopulation,options.MutationFcnArgs{:});

% group them into the next generation
Population = [ eliteKids ; xoverKids ; mutateKids ];

% score the population
%We want to add the vectorizer if fitness function is NOT vectorized
if strcmpi(options.Vectorized, 'off')
    Score = feval(@fcnvectorizer,Population,FitnessFcn,options.FitnessFcnArgs{:});
else
    Score = feval(FitnessFcn,Population,options.FitnessFcnArgs{:});
end

%[thisPopulation,thisScore] = gaFmin(options,GenomeLength,FitnessFcn,thisScore,thisPopulation);

%options.AnnealFcnArgs{:}
[nextPopulation,nextScore] = PopAnneal6(options,GenomeLength,FitnessFcn,state,Score,Population);

state.FunEval = state.FunEval + options.PopulationSize;

