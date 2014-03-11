function Es = smoothnessEnergy(X, Y, curPt)
Es = curvature(X(curPt-1), Y(curPt-1),
               X(curPt), Y(curPt),
               X(curPt+1), Y(curPt+1));

