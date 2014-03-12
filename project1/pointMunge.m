% Ensures there are enough points in the input arrays
function [newX,newY] = pointMunge(X, Y) 

%if numel(X) < 40
%    c = 1;
%    for i = 1:numel(X)
%        for j = 1:10
%            newX(c) = X(i);
%            newY(c) = Y(i);
%            c = c + 1;
%        end
%    end
%end

newX(1) = X(1);
newY(1) = Y(1);
c = 2;
for i=2:numel(X)
    newX(c) = round((X(i-1) + X(i))/2);
    newY(c) = round((Y(i-1) + Y(i))/2);
    c = c + 1;
    newX(c) = round(X(i));
    newY(c) = round(Y(i));
    c = c + 1;
end

newX = transpose(newX);
newY = transpose(newY);

