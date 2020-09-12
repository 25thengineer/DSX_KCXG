function options = constrValidate(A,L,U,IndEqcstr,IndIneqcstr,nonlcon,options,subtype,type)
%CONSTRVALIDATE validate parameters related to constraint GA
%   Private to GACONSTR

%   Copyright 2005 The MathWorks, Inc.
%   $Revision: 1.1.6.2.2.1 $  $Date: 2005/07/17 06:06:31 $

options.NonconFcn = [];
options.(['NonconFcn' 'Args']) = {};

% Check linear constraint satisfaction at stopping?
linconCheck = false;
% Create a structure to store linear constraint information
options.LinearConstr = struct('A',A,'L',L,'U',U,'IndEqcstr',IndEqcstr, ...
    'IndIneqcstr',IndIneqcstr,'type',subtype);
% Creation, mutation, and crossover functions for constrained GA
if ~strcmpi(subtype,'unconstrained')
    mutationFcn = func2str(options.MutationFcn);
    if any(strcmpi(mutationFcn,{'mutationuniform', 'mutationgaussian'}))
        msg = sprintf('''%s'' mutation function is for unconstrained minimization only;\n using @mutationadaptfeasible mutation function.',mutationFcn);
        msg = [msg,sprintf('\nSet @mutationadaptfeasible as MutationFcn options using GAOPTIMSET.\n')];
        warning('gads:CONSTRVALIDATE:constrainedMutation',msg);
        options.MutationFcn = @mutationadaptfeasible;
        % This must be a custom mutation function so we check linear
        % constraints at the end
    elseif ~strcmpi(mutationFcn,'mutationadaptfeasible')
        linconCheck = true;
    end
end
options.LinearConstr.linconCheck = linconCheck;

%-------------------------------------------------------------------------
% if it's a scalar fcn handle or a cellarray starting with a fcn handle and
% followed by something other than a fcn handle, return parts, else empty
function [handle,args] =  isFcn(x)
  handle = [];
  args = {};
%If x is a cell array with additional arguments, handle them
if iscell(x) && ~isempty(x)
    args = x(2:end);
    handle = x{1};
else
    args = {};
    handle = x;
end
%Only function_handle or inlines are allowed
if  ~(isa(handle,'inline') || isa(handle,'function_handle'))
    handle = [];
end

