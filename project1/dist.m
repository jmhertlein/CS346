%simple pythagorean theorem-based distance formula
% (x,y) is point 1
% (u,v) is point 2
function d = dist(x, y, u, v)

d = sqrt((u - x)^2 + (v - y)^2);
