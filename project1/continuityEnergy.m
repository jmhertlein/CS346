% d is the average distance between all points, computer once per iteration
% (x,y) are the point we're at
% (u,v) are the previous point
function [Ec] = continuityEnergy(d, x, y, u, v)
%d is average dist between all points

Ec = (d-abs(dist(x, y, u, v)))^2;
