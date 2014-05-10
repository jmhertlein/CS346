pkg load image;

clear all; clc; close all;

% read source and dest images
left = imread('conesLeft.ppm');
right = imread('conesRight.ppm');

[leftnr,leftnc,leftnl] = size(left)
[rightnr,rightnc,rightnl] = size(right)


% for each row

  % compute DSI using (1-NCC)

  % useDP on DSI to find min-cost path

  % back-trace & compute disparity

% fill in occlusion
