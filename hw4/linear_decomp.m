% Author: Joshua Hertlein

x = [17 23 35 37 45 57 61 70 80 84];
y = [81 72 73 58 50 56 36 32 32 19];

res(1,1) = sum(x.*x);
res(1,2) = sum(x.*y);
res(1,3) = sum(x);
res(2,1) = sum(x.*y);
res(2,2) = sum(y.*y);
res(2,3) = sum(y);
res(3,1) = sum(x);
res(3,2) = sum(y);
res(3,3) = numel(x);

res;

[V, D] = eig(res);
vals = [D(1,1) D(2,2) D(3,3)];
[c, i] = min(vals);

solution = V(:, i);

solution
% solution =
%    -0.0092193
%    -0.0103518
%     0.9999039

