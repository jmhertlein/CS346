function [Ec] = continuityEnergy(d, x, y, u, v)
%d is average dist between all points

Ec = (d-abs(dist(
                 x, y, 
                 u, v
                )
           )
     )^2;
