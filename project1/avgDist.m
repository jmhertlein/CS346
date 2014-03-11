function d = avgDist(X, Y)

total = 0;

for i = 2:numel(X)
  total = total + dist(X(i), Y(i), X(i-1), Y(i-1));
end

d = total / numel(X);
