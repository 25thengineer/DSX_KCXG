function plotBins(Xbin,Y,xstr,ystr,tstr)
% Binned data plot method supplied with SA Tools.
% Copyright (c) 2002, by Richard Frost and Frost Concepts.
% See http://www.frostconcepts.com/software for information on SA Tools.
%
% plotBins(Xbin,Y,xstr,ystr,tstr)
%
%   Xbin = bin centroids, min, and max
%           Xbin(1,:) are bin centroids.  Xbin(1,b) is the centroid for Y(b).
%           Xbin(2,:) are bin lower bounds
%           Xbin(3,:) are bin upper bounds
%   Y = frequency, or relative frequency, etc.
%           Y is the same size as Xbin(1,:)
%           Y is assumed to contain non-negative values.
%   xstr = Xbin axis label
%   ystr = Y axis label
%   tstr = plot title
%
[rows, bins] = size(Xbin) ;
%
Xbinmin = Xbin(2,1) ;
Xbinmax = Xbin(1,bins) ;    % instead of Xbin(3,bins)
Xbinrange = Xbinmax - Xbinmin ;
pad = 0.05*Xbinrange ;
xmin = Xbinmin - pad ;
xmax = Xbinmax + pad ;
ymin = 0 ;
ymax = 1.1*max(Y) ;
%
Sx(1) = Xbinmin ;
Sx(2:(bins+1)) = Xbin(2,:) ;
Sx(bins+2) = Xbin(3,bins) ;
Sx(bins+3) = Xbin(3,bins) ;
Sy(1) = 0 ;
Sy(2:(bins+1)) = Y ;
Sy(bins+2) = Y(bins) ;
Sy(bins+3) = 0 ;
%
axis([xmin xmax ymin ymax]) ;
hold on ;
title(tstr) ;
xlabel(xstr) ;
ylabel(ystr) ;
bar(Xbin(1,:),Y) ;
stairs(Sx,Sy,'r') ;
hold off ;
    