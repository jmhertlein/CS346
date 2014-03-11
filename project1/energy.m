% Our energy function

% a, b, c: weights for the gradient, continuity, and smoothness terms, respectively
% x, y: point whose energy is to be determined
% X, Y: arrays of x and y coords, respectively. together they represent the list of points the user input'd
% d: average distance between all consecutive points
% imGrad: the gradient computed from our image
function e = energy(a, b, c, x, y, curPtNum, X, Y, d, imGrad)

prev = curPtNum -1;
if prev == 0
    prev = numel(X);
end

e = a*gradientEnergy(imGrad, x, y) + b*continuityEnergy(d, x, y, X(prev), Y(prev)) + c * smoothnessEnergy(X, Y, x, y, curPtNum);
