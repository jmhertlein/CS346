function [X, Y] = U(im, x, y)
[maxY,maxX] = size(im);
X = [x-2 x-1 x x+1 x+2 x-2 x-1 x x+1 x+2 x-2 x-1 x x+1 x+2 x-2 x-1 x x+1 x+2 x-2 x-1 x x+1 x+2 ];
Y = [y+2 y+2 y+2 y+2 y+2 y+1 y+1 y+1 y+1 y+1 y y y y y y-1 y-1 y-1 y-1 y-1 y-2 y-2 y-2 y-2 y-2 ];

for i= 1:numel(X)
    if(X(i) > maxX)
        X(i) = maxX;
    end
    if(Y(i) > maxY)
        Y(i) = maxY;
    end
    if(X(i) < 1)
        X(i) = 1;
    end
    if(Y(i) < 1)
        Y(i) = 1;
    end
end


