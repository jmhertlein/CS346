function [neighborhood,pts] = U(im, x, y)

neighborhood = [im(x-1, y+1) im(x, y+1) im(x+1, y+1);
                im(x-1, y) im(x, y) im(x+1, y);
                im(x-1, y-1) im(x, y-1) im(x+1, y-1)]

pts = [x-1 y+1;
       x y+1;
       x+1 y+1;
       x-1 y;
       x y;
       x+1 y;
       x-1 y-1;
       x y-1;
       x+1 y-1]




