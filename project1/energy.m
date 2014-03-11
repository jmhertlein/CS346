function e = energy(a, b, c, point, points, d, imGrad)
e = a*gradientEnergy(imGrad, point(1), point(2), y) + b*continuityEnergy(d, points, point) + c * smoothnessEnergy(points, point);
