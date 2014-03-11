function [X, Y] = U(im, x, y)

X = [x-1 x x+1 x-1 x x+1 x-1 x x+1]
Y = [y+1 y+1 y+1 y y y y-1 y-1 y-1]
