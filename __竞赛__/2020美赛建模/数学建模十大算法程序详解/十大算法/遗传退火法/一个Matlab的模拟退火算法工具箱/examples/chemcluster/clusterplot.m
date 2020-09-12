function h = clusterplot(W)
% h = clusterplot(W)
% Method for chemcluster example supplied with SA Tools.
% See http://www.frostconcepts.com/software for information on SA Tools.
%
%   h = clusterplot(W) ;
%
%   W = N 3D points.
%   N = number of molecules
%
%   Produces a scatter plot of a cluster state.
%
scatter3(W(:,1),W(:,2),W(:,3),'filled') ;
