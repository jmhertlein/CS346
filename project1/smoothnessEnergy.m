function Es = smoothnessEnergy(points, curPt)
Es = curvature(points(curPt-1, 1), points(curPt-1, 2),
               points(curPt, 1), points(curPt, 2),
               points(curPt+1, 1), points(curPt+1, 2));

