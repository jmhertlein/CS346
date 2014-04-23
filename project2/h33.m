% Function to compute h assuming h_33 = 1

% x, y: the x and y coords of the correlation points in the source image
% X, Y: the x and y coords of the correlation points in the destination image
function h = h33(x, y, X, Y)

for i = 1:numel(x)
    A(i*2-1, 1) = x(i);
    A(i*2-1, 2) = y(i);
    A(i*2-1, 3) = 1;
    A(i*2-1, 4) = 0;
    A(i*2-1, 5) = 0;
    A(i*2-1, 6) = 0;
    A(i*2-1, 7) = (-1)*(x(i)*X(i));
    A(i*2-1, 8) = (-1)*(y(i)*X(i));

    A(i*2, 1) = 0;
    A(i*2, 2) = 0;
    A(i*2, 3) = 0;
    A(i*2, 4) = x(i);
    A(i*2, 5) = y(i);
    A(i*2, 6) = 1;
    A(i*2, 7) = (-1)*(x(i)*Y(i));
    A(i*2, 8) = (-1)*(y(i)*Y(i));
end
    
