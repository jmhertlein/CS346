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
figure(1); imshow(source,[]); title('source');
figure(2); imshow(dest,[]); title('destination');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Step 1: manually select correpsonding points
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fLoad = true;
if ~fLoad    
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
    
    %show points in source
    %figure(1);
    %hold on; plot(xpts, ypts, 'rs','Markersize',12);
    %text(xpts, ypts, num2str((1:length(xpts))'),'Color','r')
    %hold off;
    
    %show points in destination
    %figure(2);
    %hold on; plot(xprimes, yprimes, 'gs','Markersize',12);
    %text(xprimes,yprimes,num2str((1:length(xpts))'),'Color','g');    
    %hold off;
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
H=h_method1
[srcnrows, srcncols, srcnlayers] = size(source)
[destnrows, destncols, destnlayers] = size(dest)

%%%%%%%%%%%%55
topLeft = (H*[0;0;1]);
topRight = (H*[srcncols; 0; 1]);
bottomLeft = (H*[0; srcnrows; 1]);
bottomRight = (H*[srcncols;srcnrows;1]);

Xs = [round(topLeft(1)/topLeft(3)) round(topRight(1)/topRight(3)) round(bottomLeft(1)/bottomLeft(3)) round(bottomRight(1)/bottomRight(3)) 0 destncols];
Ys = [topLeft(2)/topLeft(3) topRight(2)/topRight(3) bottomLeft(2)/bottomLeft(3) bottomRight(2)/bottomRight(3) 0 destnrows];

Ys = round(Ys);
Xs = round(Xs);

minX = min(Xs);
maxX = max(Xs);
minY = min(Ys);
maxY = max(Ys);

shiftX = 0;
shiftY = 0;
if minX <= 0
    shiftX = abs(minX) + 1;
    maxX = maxX + shiftX;
end
if(minY <= 0)
    shiftY = abs(minY)+1;
    maxY = maxY + shiftY;
end

maxX
maxY


warpedSrc= zeros(maxY+1, maxX+1, 3);
%%%%%%%%%%%%%%%%%
%copy dest img
for x = 1:destncols
  for y = 1:destnrows
    warpedSrc(y+shiftY,x+shiftX,1)=dest(y,x, 1);
    warpedSrc(y+shiftY,x+shiftX,2)=dest(y,x, 2);
    warpedSrc(y+shiftY,x+shiftX,3)=dest(y,x, 3);
  end
  printf('Finished copying col: %d of %d\n', x, srcncols);
end

input('type something\n');
for x = 1:srcncols
  for y = 1:srcnrows
    p = [x; y; 1];
    pprime=H*p;
    xprime = (round(pprime(1)/pprime(3)));
    yprime = (round(pprime(2)/pprime(3)));
    %if xprime<1 || xprime>destncols || yprime<1 || yprime>destnrows
    %  continue;
    %end
      warpedSrc(yprime+shiftY,xprime+shiftX,1)=source(y,x, 1);
      warpedSrc(yprime+shiftY,xprime+shiftX,2)=source(y,x, 2);
      warpedSrc(yprime+shiftY,xprime+shiftX,3)=source(y,x, 3);
  end
  printf('Finished warping col: %d of %d\n', x, srcncols);
end
printf('Done crunching numbers\n');
figure; imshow(uint8(warpedSrc));
[a,b,c] = size(warpedSrc)
input('cont');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Step 4: stitch two images together
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure; imshow(uint8(warpedSrc));
input('done');
