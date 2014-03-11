pkg load image;
clc; %clear the command window 
close all; %close all figure windows
clear all; %clear all variables in the workspace

%read the image
%im = double(imread('objectsForActiveContours.png'))/255;
im = rgb2gray(double(imread('objectsForActiveContours.png')));
[nrows,ncols] = size(im);

%your code to compute the gradient
[Gmag, Gdir] = imgradient(im); %gmag is the one we want to use

%parameters
f = 1/5; %the minimum fraction of points to change
a = 10; %gradient weight in energy function
b = .5; %continuity weight in energy function
c = 1; %smoothness weight in energy function
%and some other parameters you will use

%initialization, save the points into mat files without manually choosing
%points everytime when you develop/debug your codes
figure(1); imshow(im); 
if 1
    [x, y] = ginput; %hit enter to finishing mouse click
    x = round(x); y = round(y);
     save('initPts2.mat','x','y');
else
    load('initPts2.mat','x','y');
end

X = x;
Y = y;

N = numel(x);

%visualize the initial points
hold on;
plot([x; x(1)], [y; y(1)], 'r-*');
hold off; drawnow;
%disp('Hit your keyboard to continue...');
%pause

cntPt = inf;
while cntPt>f*N
    %your codes for iterative active contour
    printf('Computing avg distanced\n');
    d = avgDist(X, Y);
    printf('Computed avg distance... is %d\n', d);
    for i = 1:N
        [nX,nY] = U(im, X(i), Y(i));
        leastEnergyAmt = inf;
        leastEnergyIndex = -1;

        for neighbor = 1:numel(nX)
            curEnergy = energy(a, b, c, nX(neighbor), nY(neighbor), i, X, Y, d, Gmag);
            %printf('Neighbor %d: (%d, %d): %f\n', neighbor, nX(neighbor), nY(neighbor), curEnergy);
            if curEnergy < leastEnergyAmt
                leastEnergyAmt = curEnergy;
                leastEnergyIndex = neighbor;
            end
        end
        printf('%d: (%d, %d) -> (%d, %d)\n', i, X(i), Y(i), nX(leastEnergyIndex), nY(leastEnergyIndex));
        X(i) = nX(leastEnergyIndex);
        Y(i) = nY(leastEnergyIndex);

        %printf('G at %d: %f\n', i, Gmag(X(i), Y(i)));
    end
    %visualize the shrink process
    figure(2); clf; imshow(Gmag); hold on;
    plot([X; X(1)], [Y; Y(1)], 'r-*');
    %plot([Y; Y(1)], [X; X(1)], 'r-*');
    hold off; drawnow;
end
