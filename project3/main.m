pkg load image;
pkg load miscellaneous;

clear all; clc; close all;

PATCH_SIZE = 10;
OCC_COST = .2;
DSI_BAND_MAX = 64;

SHOW = 0;
SHOW_I = 1;
EXIT_AFTER_SHOW = 0;

% read source and dest images
left = rgb2gray(imread('conesLeft.ppm'));
right = rgb2gray(imread('conesRight.ppm'));

[leftnr,leftnc,leftnl] = size(left);
[rightnr,rightnc,rightnl] = size(right);

width = 5;
hwidth = round((width - 1) /2); %patch size for NCC matching

nrows = leftnr - 2*hwidth; 
ncols = rightnr - 2*hwidth;

% for each row
for row = 1+hwidth:size(left,1)-hwidth %loop on each row except top

  % compute DSI using (1-NCC)
  lPatches = im2col(left(row-hwidth:row+hwidth,:),[width width]);
  rPatches = im2col(right(row-hwidth:row+hwidth,:),[width width]);
  lNorm= normc(double(lPatches - ones(width^2,1) * mean(lPatches)));
  rNorm= normc(double(rPatches - ones(width^2,1) * mean(rPatches)));
  DSI = 1 - (rNorm' * lNorm);

  % Optionally show a DSI and exit
  if(SHOW && row == SHOW_I)
    disp = uint8(DSI * 256); % 1-NCC ranges from 0-2, so let's scale it
    imshow(disp);
    input('Enter to continue');
    if(EXIT_AFTER_SHOW)
      exit
    end
  end
  
  % use DP on DSI to find min-cost path
  [costs, moves] = dpPath(DSI, OCC_COST, DSI_BAND_MAX);


  % back-trace & compute disparity
  [row, col] = size(moves);
  while(row >= 1 && col >= 1)
    DSI(row, col) = 255;
    if(moves(row, col) == 1)
      row = row - 1;
      col = col - 1;
    elseif (moves(row,col) == 2)
      row = row - 1;
    else
      col = col - 1;
    end
  end

  imshow(uint8(DSI * 128));
  input('');
  exit
  
end

% fill in occlusion
