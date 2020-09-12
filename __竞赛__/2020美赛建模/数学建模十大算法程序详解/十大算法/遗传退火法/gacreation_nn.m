function Population = gacreation_nn(GenomeLength,FitnessFcn,options)
%GACREATION_NN Creates the initial population for genetic algorithm.
%   POP = GACREATION_NN(NVARS,FITNESSFCN,OPTIONS) Creates the
%   initial population that GA will then evolve into a solution.
%
%   Population size can be a vector of separate populations.
%   Here, we are only interested in the total number.
%
%   Example:
%     options = gaoptimset('PopulationType','bitString');
%            NVARS = 1; FitnessFcn = @ackelyfcn;
%
%     pop = GACREATION_NN(NVARS,FitnessFcn,options);
%
%   pop will be a 20-by-1 logical column vector.  Note that the
%   default Population Size in GAOPTIMSET is 20.

popSize = sum(options.PopulationSize);

if(strcmpi(options.PopulationType,'doubleVector'))
    if ~isfield(options,'LinearConstr')
        linConLen = 0;
        range = options.PopInitRange;
        lBound = range(1,:);
        uBound = range(2,:);
    else
        linCon = options.LinearConstr;
        type = linCon.type;
        % Sub-problem type is constrained?
        if strcmpi(type,'unconstrained')
            linConLen = 0;
            range = options.PopInitRange;
            lBound = range(1,:);
            uBound = range(2,:);
        else
            IndIneqcstr = linCon.IndIneqcstr;
            A = [linCon.A(IndIneqcstr,:)];
            b = [linCon.U(IndIneqcstr)];
            linConLen = length(b);
            
            lBound = linCon.L((end-GenomeLength)+1:end);
            uBound = linCon.U((end-GenomeLength)+1:end);
            z = [lBound,uBound];
            flag2 = (z-(1e+20)>0);
            z(flag2) = 1e+20;
            flag2 = (z+(1e+20)<0);
            z(flag2) = -1e+20;
            lBound = z(:,1)';
            uBound = z(:,2)';
        end
    end
    span = uBound - lBound;
    Population0 = repmat(lBound,popSize,1) + repmat(span,popSize,1) .* rand(popSize,GenomeLength);
    
    if linConLen > 0
        y = (A*Population0')';
        flag2 = [];
        for i=1:linConLen
            flag2(:,i) = (y(:,i)<b(i));
        end
        flag2 = all(flag2,2);
        Population2 = Population0(flag2,:);
        nv = size(Population2,1);

        K = (popSize/nv+1);
        while nv < popSize
            nPop2 = ceil(K * (popSize-nv));
            Population0 = repmat(lBound,nPop2,1) + repmat(span,nPop2,1) .* rand(nPop2,GenomeLength);
            y = (A*Population0')';
            flag2 = [];
            for i=1:linConLen
                flag2(:,i) = (y(:,i)<b(i));
            end
            flag2 = all(flag2,2);
            Population2 = [Population2;Population0(flag2,:)];
            nv = size(Population2,1);
        end
        Population0(1:popSize,:) = Population2(1:popSize,:);
    end
else
    msg = sprintf('Unknown population type ''%s'' in problem.',options.PopulationType);
    error('gads:GACREATIONUNIFORM:unknownPopulationType',msg);
end
Population = Population0;

if all(isnan(Population))
    msg = sprintf(['Initial population contains NaN;','OPTIONS.PopInitRange is possibly too big.']);
    error('gads:GACREATIONUNIFORM:populationIsNaN',msg);
elseif all(isinf(Population))
    msg = sprintf(['Initial population contains Inf;','OPTIONS.PopInitRange is possibly too big.']);
    error('gads:GACREATIONUNIFORM:populationIsInf',msg);
end
