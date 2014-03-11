%imGrad is the gradient computed for our image
%x and y are the point's x and y coords
function [Eg] =gradientEnergy(imGrad, x, y)
Eg = -abs(imGrad(y,x));
