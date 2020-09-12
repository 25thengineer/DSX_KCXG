function [Population,Score] = PopAnneal(options,GenomeLength,FitnessFcn, ...
    state,thisScore,thisPopulation)
R=10;L=GenomeLength*100;
%T0=0.1;alpha=0.8;
%t = T0 * alpha^(state.Generation);

nParents = size(thisPopulation,1);
nAnneal = round(nParents / R /2);

[Score,k] = sort(thisScore);
Population  = thisPopulation(k,:);

t = min(1/sqrt(eps),(Score(nAnneal*R)-Score(1))/(log(nAnneal*R)-log(nAnneal*R-1)));
t = max(sqrt(eps),t);

shrink=0.9;
stepSize = max(sqrt(eps),shrink^(state.Generation));

if isfield(options,'LinearConstr')
    % Extract information about constraints
    linCon = options.LinearConstr;
    type = linCon.type;
    % Sub-problem type is constrained?
    if ~strcmpi(type,'unconstrained')
        A = linCon.A;
        LB = linCon.L;
        UB = linCon.U;
    end
end

Lbnd = min(Population);%(1:nParents/2,:)
Ubnd = max(Population);
Bound = [Lbnd;Ubnd];

PopAnneal = [];
ScoreAnneal = [];
for i = 1:nAnneal
    x = Population(i,:);
    fx = Score(i);
    [X2,fX2] = Anneal(x,fx,FitnessFcn,Bound,stepSize^2,A,LB,UB,R,L,t*stepSize);
    PopAnneal = [PopAnneal;X2];
    ScoreAnneal = [ScoreAnneal;fX2];
end

Population = [PopAnneal;Population];
Score = [ScoreAnneal;Score];

[Score,k] = sort(Score);
Population  = Population(k,:);

Population = Population(1:nParents,:);
Score = Score(1:nParents,:);
