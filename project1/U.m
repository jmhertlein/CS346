function [pts] = U(im, x, y)
pts = [x-1 y+1;
       x y+1;
       x+1 y+1;
       x-1 y;
       x y;
       x+1 y;
       x-1 y-1;
       x y-1;
       x+1 y-1]
