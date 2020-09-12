function [Population,Score] = PopAnneal(options,GenomeLength,FitnessFcn,state,thisScore,thisPopulation)
R=1;L=300;
%T0=1000;alpha=0.8;
%t = T0 * alpha^(state.Generation);

nParents = size(thisPopulation,1);
nAnneal = nParents;

[Score,k] = sort(thisScore);
Population  = thisPopulation(k,:);

t = 10000;

shrink=0.95;
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
        Lbnd = LB((end-GenomeLength)+1:end);
        Ubnd = UB((end-GenomeLength)+1:end);
    else % Or unconstrained sub-problem
        Lbnd = -(1e+20)*ones(GenomeLength,1);
        Ubnd = (1e+20)*ones(GenomeLength,1);
    end
else % Unconstrained 'main' problems;
    type = 'unconstrained';
    Lbnd = -(1e+20)*ones(GenomeLength,1);
    Ubnd = (1e+20)*ones(GenomeLength,1);
end

Bound = [Lbnd';Ubnd'];

PopAnneal = [];
ScoreAnneal = [];
for i = 1:nAnneal
    x = Population(i,:);
    fx = Score(i);
    [X2,fX2] = Anneal(x,fx,FitnessFcn,Bound,stepSize,A,LB,UB,R,L,t*stepSize^2);
    PopAnneal = [PopAnneal;X2];
    ScoreAnneal = [ScoreAnneal;fX2];
end

Population = [PopAnneal;Population];
Score = [ScoreAnneal;Score];

[Score,k] = sort(Score);
Population  = Population(k,:);

Population = Population(1:nParents,:);
Score = Score(1:nParents,:);

