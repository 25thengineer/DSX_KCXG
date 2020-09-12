function [Population,Score] = PopAnneal(options,GenomeLength,FitnessFcn, ...
    state,thisScore,thisPopulation)
R=10;L=GenomeLength*100;
%T0=1000;alpha=0.8;
%t = T0 * alpha^(state.Generation);

nParents = size(thisPopulation,1);
nAnneal = ceil(nParents / R /2);

[Score,k] = sort(thisScore);
Population  = thisPopulation(k,:);

t = min(1/sqrt(eps),(Score(nAnneal*R)-Score(1))/log(2));%ta = 0.85;
t = max(sqrt(eps),t);

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

Lbnd2 = min(Population(1:nParents/2,:));%(1:nParents/2,:)
Ubnd2 = max(Population(1:nParents/2,:));

k2 = state.Generation;
shrink = 0.95;
stepSize = max(sqrt(eps),shrink^k2);
Lbnd = (Lbnd2' + stepSize*Lbnd) / (1+stepSize);
Ubnd = (Ubnd2' + stepSize*Ubnd) / (1+stepSize);

Bound = [Lbnd';Ubnd'];

ta = 0.78;
ta = max(sqrt(eps),ta^(k2^(1/2)));

shrink = 0.95;
stepSize = max(sqrt(eps),shrink^k2);

PopAnneal = [];
ScoreAnneal = [];
for i = 1:nAnneal
    x = Population(i,:);
    fx = Score(i);
    [X2,fX2] = Anneal(x,fx,FitnessFcn,Bound,stepSize,A,LB,UB,R,L,t*ta);%
    PopAnneal = [PopAnneal;X2];
    ScoreAnneal = [ScoreAnneal;fX2];
end
x = mean(Population(1:nAnneal*R,:));%
fx = feval(FitnessFcn,x);
PopAnneal = [PopAnneal;x];
ScoreAnneal = [ScoreAnneal;fx];
[X2,fX2] = Anneal(x,fx,FitnessFcn,Bound,stepSize,A,LB,UB,R,L,t*ta);%
PopAnneal = [PopAnneal;X2];
ScoreAnneal = [ScoreAnneal;fX2];

Population = [PopAnneal;Population];
Score = [ScoreAnneal;Score];

[Score,k] = sort(Score);
Population  = Population(k,:);

Population = Population(1:nParents,:);
Score = Score(1:nParents,:);
