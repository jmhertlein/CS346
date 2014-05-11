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
rebuilt = zeros(leftnr, leftnc);
disparity = zeros(leftnr, leftnc);
width = 5;
hwidth = round((width - 1) /2); %patch size for NCC matching

nrows = leftnr - 2*hwidth; 
ncols = rightnr - 2*hwidth;


% for each row
for row = 1+hwidth:size(left,1)-hwidth %loop on each row except top
  row
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

  DSI = DSI * 128; % scale DSI so we can show the traceback

  % back-trace & compute disparity
  [r, c] = size(moves);
  while(r >= 1 && c >= 1)
    DSI(r, c) = 255; % highlight our path in white
    if(moves(r, c) == 1)
      rebuilt(row, c) = left(row, c);
      disparity(row, c) = c - r;
      r = r - 1;
      c = c - 1;
    elseif (moves(r,c) == 2)
      r = r - 1;
    else
      rebuilt(row, c) = 0;
      disparity(row, c) = 0; 
      c = c - 1;
    end
  end
  %imshow(uint8(rebuilt));
  imshow(uint8(DSI));
  drawnow;
end

imshow(uint8(rebuilt));
input('rebuilt...');

dispScalar = 255 / max(max(disparity));
imshow(uint8(disparity * dispScalar));
input('disparity (unfilled)...');

% fill in occlusion
[disprows, dispcols] = size(disparity);
for row = 1:disprows
  lastValid = 0;
  for col = 1:dispcols
    if(disparity(row, col) == 0)
      disparity(row, col) = lastValid;
    else
      lastValid = disparity(row, col);
    end
  end
end

dispScalar = 255 / max(max(disparity));
imshow(uint8(disparity * dispScalar));
input('disparity (filled)...');
