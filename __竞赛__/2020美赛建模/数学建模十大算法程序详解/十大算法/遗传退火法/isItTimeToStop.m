function reasonToStop = isItTimeToStop(options,state)
% Check to see if any of the stopping criteria have been met.
%   isItTimeToStop(options,state); is a string containing the reason the ga
%   should be stopped. The empty string means that it is not time to stop.

%   Copyright 2003-2005 The MathWorks, Inc.
%   $Revision: 1.6.4.4 $  $Date: 2005/06/21 19:21:42 $


funChange = Inf;
Gen = state.Generation;
GenomeLength = size(state.Population,2);
PopSize = size(state.Population,1);
if any(strcmpi(options.Display, {'iter','diagnose'}))
    FunEval  = Gen*length(state.Score);
    BestFval = state.Best(Gen);
    MeanFval = meanf(state.Score);
    StallGen = Gen  - state.LastImprovement;
    fprintf('%5.0f         %5.0f    %12.4g    %12.4g    %5.0f\n', ...
        Gen, FunEval, BestFval, MeanFval, StallGen);
end
% Window used to get best fval
Window = options.StallGenLimit;
Weight = 0.5;
% Compute change in fval and individuals in last 'Window' generations
if Gen > Window
    Bestfvals =  state.Best((Gen-Window):end);
    funChange = 0;
    for i = 1:Window-1
        funChange = funChange + Weight^(Window-i)*(abs(Bestfvals(i+1) - Bestfvals(i))/(abs(Bestfvals(i))+1));
    end
    % Take an average of function value change
    funChange = funChange/Window;
end

reasonToStop = [];
if(state.Generation >= options.Generations)
    reasonToStop = sprintf(['Optimization terminated: ','maximum number of generations exceeded.']);
elseif((cputime-state.StartTime) > options.TimeLimit)
    reasonToStop = sprintf(['Optimization terminated: ','time limit exceeded.']);
elseif((cputime-state.LastImprovementTime) > options.StallTimeLimit)
    reasonToStop = sprintf(['Optimization terminated: ','stall time limit exceeded.']);
elseif((state.Generation  - state.LastImprovement) > options.StallGenLimit)
    reasonToStop = sprintf(['Optimization terminated: ','stall generations limit exceeded.']);
elseif(min(min(state.Score)) <= options.FitnessLimit )
    reasonToStop = sprintf(['Optimization terminated: ','minimum fitness limit reached.']);
elseif(~isempty(state.StopFlag))
    reasonToStop = sprintf(['Optimization terminated: ',state.StopFlag]);
elseif funChange <= options.TolFun
    reasonToStop = sprintf(['Optimization terminated: average change in the fitness value less than options.TolFun.']);
end

% If it is a constrained problem and we want to check linear
% constraints (when GA is terminating)
if ~isempty(reasonToStop) && isfield(options,'LinearConstr')
        linCon = options.LinearConstr;
        if linCon.linconCheck && ~feasibleLinearConstraints
          reasonToStop = [reasonToStop,...
              sprintf('\n%s','Linear constraints are not satisfied within constraint tolerance.')];
        end
end

if ~isempty(reasonToStop) && any(strcmpi(options.Display, {'iter','diagnose','final'}))
    fprintf('%s\n',reasonToStop);
    return;
end
% Print header again
if any(strcmpi(options.Display, {'iter','diagnose'})) && rem(Gen,30)==0 && Gen > 0
    fprintf('\n                               Best           Mean      Stall\n');
    fprintf('Generation      f-count        f(x)           f(x)    Generations\n');
end
%------------------------------------------------
    function feasible  = feasibleLinearConstraints
        % Function to check if linear constraints are satisfied at final point
        % If it is a constrained problem and we want to check linear constraints
        A = linCon.A;
        L = linCon.L;
        U = linCon.U;
        IndEqcstr = linCon.IndEqcstr;
        tol = sqrt(options.TolCon);
        [FVAL,best] = min(state.Score);
        X = state.Population(best,:);
        feasible = isfeasible(X',A,L,U,tol,IndEqcstr);
    end % End of feasibleLinearConstraints
    %------------------------------------------------
    function m = meanf(x)
        nans = isnan(x);
        x(nans) = 0;
        n = sum(~nans);
        n(n==0) = NaN; % prevent divideByZero warnings
        % Sum up non-NaNs, and divide by the number of non-NaNs.
        m = sum(x) ./ n;
    end
end
