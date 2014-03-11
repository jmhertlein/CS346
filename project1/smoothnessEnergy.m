function Es = smoothnessEnergy(X, Y, x, y, curPt)
prev = curPt - 1
next = curPt + 1

if prev == 0
    prev = numel(X)
end

if next > numel(X)
    next = 0
end

Es = curvature(X(prev), Y(prev),
               x, y,
               X(next), Y(next));

