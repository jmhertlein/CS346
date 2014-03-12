%pkg load image;
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
f = 1/10; %the minimum fraction of points to change
a = 20; %gradient weight in energy function
b = 2; %continuity weight in energy function
c = 7; %smoothness weight in energy function
munges = 5;
%and some other parameters you will use

%initialization, save the points into mat files without manually choosing
%points everytime when you develop/debug your codes
figure(1); imshow(im); 
if 0
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
disp('Hit your keyboard to continue...');
pause

X
Y
for i = 1:munges
    [X,Y] = pointMunge(X, Y);
end
X
Y
N = numel(X);

hold on;
plot([X; X(1)], [Y; Y(1)], 'r-*');
hold off; drawnow;
disp('Points interpolated. Hit your keyboard to continue...');
pause

cntPt = inf;
threshold = f*N;
if (f*N) == 0
    threshold = (1/3)*N;
end

maxIterations = 250;
iterations = 0;
while cntPt>threshold && iterations < maxIterations
    cntPt = 0;
    %your codes for iterative active contour
    %printf('Computing avg distanced\n');
    d = avgDist(X, Y);
    %printf('Computed avg distance... is %d\n', d);
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
        %printf('%d: (%d, %d) -> (%d, %d)\n', i, X(i), Y(i), nX(leastEnergyIndex), nY(leastEnergyIndex));
        oldX = X(i);
        oldY = Y(i);
        X(i) = nX(leastEnergyIndex);
        Y(i) = nY(leastEnergyIndex);

        if oldY ~= Y(i) || oldX ~= X(i)
            cntPt = cntPt + 1;
        end

        %printf('G at %d: %f\n', i, Gmag(X(i), Y(i)));
    end
    %visualize the shrink process
    figure(2); clf; imshow(Gmag); hold on;
    plot([X; X(1)], [Y; Y(1)], 'r-*');
    %plot([Y; Y(1)], [X; X(1)], 'r-*');
    hold off; drawnow;
    iterations = iterations + 1;
end

%printf('Terminated after %d iterations\n', iterations);

figure(2); clf; imshow(Gmag); hold on;
plot([X; X(1)], [Y; Y(1)], 'r-*');
hold off; drawnow;
iterations
printf('Converged, press any key to terminate.\n');
pause;
