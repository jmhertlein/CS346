function e = energy(a, b, c, point, X, Y, d, imGrad)
e = a*gradientEnergy(imGrad, point(1), point(2), y) + b*continuityEnergy(d, X, Y, point) + c * smoothnessEnergy(X, Y, point);
