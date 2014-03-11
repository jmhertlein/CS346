function [Ec] = continuityEnergy(d, X, Y, curPoint)
%d is average dist between all points

Ec = (d-abs(dist(
                 X(curPoint),   Y(curPoint), 
                 X(curPoint-1), Y(curPoint-1)
                )
           )
     )^2
