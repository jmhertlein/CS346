% Function to compute h assuming ||h|| = 1
% given n pairs of corresponding points, computs the h matrix that warps from source to destination

% x, y: the x and y coords of the correlation points in the source image
% X, Y: the x and y coords of the correlation points in the destination image
function h = h1(x, y, X, Y)

for i = 1:numel(x)
    A(i*2-1, 1) = x(i);
    A(i*2-1, 2) = y(i);
    A(i*2-1, 3) = 1;
    A(i*2-1, 4) = 0;
    A(i*2-1, 5) = 0;
    A(i*2-1, 6) = 0;
    A(i*2-1, 7) = (-1)*(x(i)*X(i));
    A(i*2-1, 8) = (-1)*(y(i)*X(i));
    A(i*2-1, 9) = (-1)*X(i);

    A(i*2, 1) = 0;
    A(i*2, 2) = 0;
    A(i*2, 3) = 0;
    A(i*2, 4) = x(i);
    A(i*2, 5) = y(i);
    A(i*2, 6) = 1;
    A(i*2, 7) = (-1)*(x(i)*Y(i));
    A(i*2, 8) = (-1)*(y(i)*Y(i));
    A(i*2, 9) = (-1)*Y(i);
end
% I officially don't remember anything from math 206
%[U, D, Vt] = svd(transpose(A)*A);
%[U, D, Vt] = svd(A);
%U
%D
%Vt
%transpose(Vt)
