function [X,FVAL,REASON,OUTPUT,POPULATION,SCORES] = ...
    ga_nn(FitnessFcn,GenomeLength,Aineq,Bineq,Aeq,Beq,LB,UB,options)
%GA_NN Genetic algorithm linear constrained solver.
%   Private function to GA
%
%   X = GA_NN(FITNESSFCN,NAVRS,A,b) finds a local minimum X to the function
%   FITNESSFCN, subject to the linear inequalities A*X <= B. FITNESSFCN
%   accepts input X and returns a scalar function value F evaluated at X.
%   X0 may be a scalar, vector, or matrix.
%
%   X = GA_NN(FITNESSFCN,NAVRS,A,b,Aeq,beq) finds a local minimum X to the
%   function FITNESSFCN, subject to the linear equalities Aeq*X = Beq as
%   well as A*X <= B. (Set A=[] and B=[] if no inequalities exist.)
%
%   X = GA_NN(FITNESSFCN,NAVRS,A,b,Aeq,beq,LB,UB) defines a set of lower and
%   upper bounds on the design variables, X, so that a solution is found in
%   the range LB <= X <= UB. Use empty matrices for LB and UB if no bounds
%   exist. Set LB(i) = -Inf if X(i) is unbounded below;  set UB(i) = Inf if
%   X(i) is unbounded above.
%
%   X = GA_NN(FITNESSFCN,NAVRS,A,b,Aeq,beq,LB,UB,options) minimizes
%   with the default optimization parameters replaced by values in the
%   structure OPTIONS. OPTIONS can be created with the GAOPTIMSET function.
%   See GAOPTIMSET for details.
%
%   [X, FVAL] = GA_NN(FITNESSFCN, ...) returns FVAL, the value of the
%   fitness function FITNESSFCN at the solution X.
%
%   [X,FVAL,REASON] = GA_NN(FITNESSFCN, ...) returns the REASON for
%   stopping.
%
%   [X,FVAL,REASON,OUTPUT] = GA_NN(FITNESSFCN, ...) returns a
%   structure OUTPUT with the following information:
%            randstate: <State of the function RAND used before GA started>
%           randnstate: <State of the function RANDN used before GA started>
%          generations: <Total generations, excluding HybridFcn iterations>
%            funccount: <Total function evaluations>
%              message: <GA termination message>
%
%   [X,FVAL,REASON,OUTPUT,POPULATION] = GA_NN(FITNESSFCN, ...) returns the
%   final POPULATION at termination.
%
%   [X,FVAL,REASON,OUTPUT,POPULATION,SCORES] = GA_NN(FITNESSFCN, ...)
%   returns the SCORES of the final POPULATION.
%
%   See also GAOPTIMSET, FITNESSFUNCTION, PATTERNSEARCH, @.

defaultopt = gaoptimset;

% If just 'defaults' passed in, return the default options in X
if nargin == 1 && nargout <= 1 && isequal(FitnessFcn,'defaults')
    X = defaultopt;
    return
end
% Use default options if empty
if ~isempty(options) && ~isa(options,'struct')
    error('gads:GALINCON:ninthInputNotStruct','Invalid input argument to GALINCON.');
elseif isempty(options)
    options = gaoptimset;
end
% Initialize output args
X = []; FVAL = []; REASON = [];POPULATION=[];SCORES=[];state = [];
user_options = options; EXITFLAG = [];
% Determine the verbosity
switch  gaoptimget(options,'Display',defaultopt,'fast')
    case {'off','none'}
        verbosity = 0;
    case 'final'
        verbosity = 1;
    case 'iter'
        verbosity = 2;
    case 'diagnose'
        verbosity = 3;
    otherwise
        verbosity = 1;
end

% Validate options and fitness function
[GenomeLength,FitnessFcn,options] = validate(GenomeLength,FitnessFcn,options);

%Remember the random number states used
output.randstate  = rand('state');
output.randnstate = randn('state');
output.generations = 0;
output.funccount   = 0;
output.message   = '';

if (isempty(Aeq) && isempty(Aineq) && isempty(Bineq) && isempty(Beq) && isempty(LB) && isempty(UB))
    type = 'unconstrained';
elseif ~isempty(Aeq) || ~isempty(Aineq) || ~isempty(LB) || ~isempty(UB)
    % Type of optimization problem
    if ~isempty(Aineq) || ~isempty(Aeq)
        type = 'linearconstraints';
    elseif ~isempty(LB) || ~isempty(UB)
        type = 'boundconstraints';
    else
        type = 'unconstrained'; % Should not reach here
    end

    % Bound correction
    [LB,UB,msg,EXITFLAG] = checkbound(LB,UB,GenomeLength,verbosity);
    if EXITFLAG < 0
        FVAL     =    [];
        REASON = msg;
        OUTPUT.message = msg;
        if verbosity > 0
            fprintf('%s\n',msg)
        end
        return;
    end

    % Reinitialize these
    nineqcstr = size(Aineq,1);
    neqcstr   = size(Aeq,1);
    ncstr     = nineqcstr + neqcstr;

    % Create A, as described in L & T  L <= AX <=U.
    Abox = eye(GenomeLength);
    A    = full([Aeq;Aineq;Abox]);
    U    = full([Beq;Bineq;UB]);
    L    = full([Beq;repmat(-Inf,nineqcstr,1);LB]);

    % Logical indices of constraints.
    IndIneqcstr = false(size(A,1),1);
    IndEqcstr   = false(size(A,1),1);
    IndEqcstr(1:neqcstr) = 1;
    IndIneqcstr(neqcstr+1:ncstr) = 1;

    % Validate constraints and add it to options structure
    options = constrValidate(A,L,U,IndEqcstr,IndIneqcstr,[],options,type,type);
end

% Create initial state: population, scores, status data
state = makeState(GenomeLength,FitnessFcn,options);

% Give the plot/output Fcns a chance to do any initialization they need.
state = gaplot(FitnessFcn,options,state,'init');
[state,options] = gaoutput(FitnessFcn,options,state,'init');

% Print some diagnostic information if asked for
if verbosity > 2
    gadiagnose(FitnessFcn,[],GenomeLength,type,nineqcstr,neqcstr,ncstr,user_options);
end
%Setup display header
if  any(strcmpi(options.Display, {'iter','diagnose'}))
    fprintf('\n                               Best           Mean      Stall\n');
    fprintf('Generation      f-count        f(x)           f(x)    Generations\n');
end

REASON = '';
% run the main loop until some termination condition becomes true
while isempty(REASON)
    state.Generation = state.Generation + 1;
    %Repeat for each subpopulation (element of the populationSize vector)
    offset = 0;
    totalPop = options.PopulationSize;
    % each sub-population loop
    for pop = 1:length(totalPop)
        populationSize =  totalPop(pop);
        thisPopulation = 1 + (offset:(offset + populationSize - 1));
        population = state.Population(thisPopulation,:);
        score = state.Score( thisPopulation );
        %Empty population is also possible
        if isempty(thisPopulation)
            continue;
        end
        [score,population,state] = stepGASA(score,population,options,state,GenomeLength,FitnessFcn);
        % store the results for this sub-population
        state.Population(thisPopulation,:) = population;
        state.Score(thisPopulation) = score;
        offset = offset + populationSize;
    end

    % remember the best score
    scores = state.Score;
    best = min(state.Score);
    generation = state.Generation;
    state.Best(generation) = best;
    % keep track of improvement in the best
    if((generation > 1) && finite(best))
        if(state.Best(generation-1) > best)
            state.LastImprovement = generation;
            state.LastImprovementTime = cputime;
        end
    end
    % do any migration
    state = migrate(FitnessFcn,GenomeLength,options,state);
    % update the Output
    state = gaplot(FitnessFcn,options,state,'iter');
    [state,options,optchanged] = gaoutput(FitnessFcn,options,state,'iter');
    if optchanged
        options = constrValidate(A,L,U,IndEqcstr,IndIneqcstr,[],options,type,type);
    end
    % check to see if any stopping criteria have been met
    REASON = isItTimeToStop(options,state);
end %End while loop

% find and return the best solution
[FVAL,best] = min(state.Score);
X = state.Population(best,:);

%Update output structure
OUTPUT.generations = state.Generation;
OUTPUT.funccount   = state.Generation*length(state.Score);
OUTPUT.maxconstraint = 0.0;
OUTPUT.message     = REASON;

% load up outputs
if(nargout > 4)
    POPULATION = state.Population;
    if(nargout > 5)
        SCORES = state.Score;
    end
end

% Call hybrid function
if ~isempty(options.HybridFcn) && strcmpi(options.PopulationType,'doubleVector')
    [X,FVAL] = callHybridFunction;
end
% give the Output functions a chance to finish up
gaplot(FitnessFcn,options,state,'done');
gaoutput(FitnessFcn,options,state,'done');

%-----------------------------------------------------------------
% Hybrid function
    function [xhybrid,fhybrid] = callHybridFunction
        xhybrid = X;
        fhybrid = FVAL;
        % Who is the hybrid function
        if isa(options.HybridFcn,'function_handle')
            hfunc = func2str(options.HybridFcn);
        else
            hfunc = options.HybridFcn;
        end
        % Inform about hybrid scheme
        if   verbosity > 1
            fprintf('%s%s%s\n','Switching to the hybrid optimization algorithm (',upper(hfunc),').');
        end
        % Create functions handle to be passed to hybrid function
        FitnessHybridFcn = @(x) FitnessFcn(x,options.FitnessFcnArgs{:});
        ConstrHybridFcn = [];
        % Determine which syntax to call
        switch hfunc
            case 'fmincon'
                [xx,ff,e,o] = feval(options.HybridFcn,FitnessHybridFcn,X,Aineq, ...
                    Bineq,Aeq,Beq,LB,UB,ConstrHybridFcn,options.HybridFcnArgs{:});
                OUTPUT.funccount = OUTPUT.funccount + o.funcCount;
                OUTPUT.message   = [OUTPUT.message sprintf('\nFMINCON: \n'), o.message];
            case 'patternsearch'
                [xx,ff,e,o] = feval(options.HybridFcn,FitnessHybridFcn,X,Aineq, ...
                    Bineq,Aeq,Beq,LB,UB,ConstrHybridFcn,options.HybridFcnArgs{:});
                OUTPUT.funccount = OUTPUT.funccount + o.funccount;
                OUTPUT.message   = [OUTPUT.message sprintf('\nPATTERNSEARCH: \n'), o.message];
            case {'fminsearch', 'fminunc'}
                msg = sprintf('%s is unconstrained optimization solver',upper(hfunc));
                msg = [msg, sprintf('\n%s',' using constrained solver FMINCON as hybrid function.')];
                warning('gads:GALINCON:unconstrainedHybridFcn',msg);
                % We need to store this warning state so that we can
                % display it in the GUI
                [lastmsg, lastid] = lastwarn; warning off;
                [xx,ff,e,o] = feval(@fmincon,FitnessHybridFcn,X,Aineq, ...
                    Bineq,Aeq,Beq,LB,UB,ConstrHybridFcn,options.HybridFcnArgs{:});
                warning on; lastwarn(lastmsg,lastid);
                OUTPUT.funccount = OUTPUT.funccount + o.funcCount;
                OUTPUT.message   = [OUTPUT.message sprintf('\nFMINCON: \n'), o.message];
            otherwise
                error('gads:GALINCON:hybridFcnError','Hybrid function must be one of the following:\n@FMINCON, @PATTERNSEARCH.')
        end
        % Check for exitflag and fval
        if ff < fhybrid && e > 0
            fhybrid = ff;
            xhybrid = xx;
        end
        %Inform about hybrid scheme termination
        if  verbosity > 1
            fprintf('%s%s\n',upper(hfunc), ' terminated.');
        end
    end % End of callHybridFunction
end  % End of gaconstr.m
