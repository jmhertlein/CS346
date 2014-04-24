%plane warp demo using homographies
%Zhaozheng Yin, Computer Science, MST
%Spring 2014
pkg load image;

clear all; clc; close all;

% read source and dest images
source = imread('src.jpg');
dest = imread('dest.jpg');

[destnr,destnc,destnb] = size(dest)
[srcnr,srcnc,srcnb] = size(source)
input('continue');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Step 1: manually select correpsonding points
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fLoad = true;
if ~fLoad    
    figure(1); imshow(source,[]); title('source');
    figure(2); imshow(dest,[]); title('destination');
    %click points in source
    figure(1);
    [xpts,ypts] = ginput;
    hold on; plot(xpts, ypts, 'rs','Markersize',12);
    text(xpts, ypts, num2str((1:length(xpts))'),'Color','r')
    hold off;

    %click points in destination
    figure(2);
    [xprimes,yprimes] = ginput;
    hold on; plot(xprimes, yprimes, 'gs','Markersize',12);    
    text(xprimes,yprimes,num2str((1:length(xpts))'),'Color','g');  
    hold off;

    %save the points
    save('CorrespondingPoints.mat','xpts','ypts','xprimes','yprimes');
else
    %load the point correspondece
    load('CorrespondingPoints.mat','xpts','ypts','xprimes','yprimes');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Step 2: compute homography (from source to dest coord system)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Method 1. compute h assuming h_33 = 1
h_33 = h33(xpts, ypts, xprimes, yprimes);
h_33(9) = 1;
h_method1 = transpose(reshape(h_33, 3, 3));

%Method 2. compute h with constraint ||h|| = 1
h_1 = h1(xpts, ypts, xprimes, yprimes);
h_method2 = transpose(reshape(h_1, 3, 3));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Step 3: warp source image onto dest coord system
% try forward and backward warping (nearest neighbor and bilinear
% interpolation)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
H=h_method2
figure; imshow(uint8(back_nearest(source, dest, H)));
input('done');
