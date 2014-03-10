pkg load image;
clc; %clear the command window 
close all; %close all figure windows
clear all; %clear all variables in the workspace

%read the image
%im = double(imread('objectsForActiveContours.png'))/255;
im = rgb2gray(double(imread('objectsForActiveContours.png')));
[nrows,ncols] = size(im);

%your code to compute the gradient
[Gmag, Gdir] = imgradient(im);

imshow(im)
pause
%parameters
f = ; %the minimum fraction of points to change
a = ; %continuity
b = ; %curvature
c = ; %gradient
%and some other parameters you will use

%initialization, save the points into mat files without manually choosing
%points everytime when you develop/debug your codes
figure(1); imshow(im); 
if 1
    [x, y] = ginput; %hit enter to finishing mouse click
    x = round(x); y = round(y);
%     save('initPts2.mat','x','y');
else
    load('initPts2.mat','x','y');
end
N = numel(x);

%visualize the initial points
hold on;
plot([x; x(1)], [y; y(1)], 'r-*');
hold off; drawnow;
disp('Hit your keyboard to continue...');
pause

cntPt = inf;
while cntPt>f*N
    %your codes for iterative active contour
    
    %visualize the shrink process
    figure(2); clf; imshow(im); hold on;
    plot([x; x(1)], [y; y(1)], 'r-*');
    hold off; drawnow;
end
