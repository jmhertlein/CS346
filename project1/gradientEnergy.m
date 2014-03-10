function [Eg] =gradientEnergy(imGrad, x, y)
Eg = -abs(imGrad(x,y))
