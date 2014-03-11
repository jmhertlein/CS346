function e = energy(a, b, c, x, y, curPtNum, X, Y, d, imGrad)

prev = curPtNum -1
if prev == 0
    prev = numel(X)
end

e = a*gradientEnergy(imGrad, x, y) + b*continuityEnergy(d, x, y, X(prev), Y(prev)) + c * smoothnessEnergy(X, Y, x, y, curPtNum);
