function [Ec] = continuityEnergy(d, points, curPoint)
%d is average dist between all points

Ec = (d-abs(dist(points(curPoint), points(curPoint-1))))^2
