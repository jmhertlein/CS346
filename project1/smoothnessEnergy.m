% X and Y are arrays of x coords and y coords respectively. Together they represent the points the user input'd
% x and y are the point we're at
% curPt is the index into X and Y that we're "at"

% I say "at" in quotes because x and y don't necessarily have to == X(curPt) and Y(curPt). This is useful because we're frequently checking the energy of neighbor points, with which we're hoping to replace the current point (if the neighbor has a lower energy). So decoupling x,y from X(curPt) and Y(curPt) lets you pass in the neighbor point but still use next/prev from curPt
function Es = smoothnessEnergy(X, Y, x, y, curPt)
prev = curPt - 1;
next = curPt + 1;

if prev == 0
    prev = numel(X);
end

if next > numel(X)
    next = 1;
end

Es = curvature(X(prev), Y(prev),
               x, y,
               X(next), Y(next));

