function warpedSrc = forwards(source, dest, H)

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
  printf('Finished copying col: %d of %d\n', x, destncols);
end

for x = 1:srcncols
  for y = 1:srcnrows
    p = [x; y; 1];
    pprime=H*p;
    xprime = (round(pprime(1)/pprime(3)));
    yprime = (round(pprime(2)/pprime(3)));
    warpedSrc(yprime+shiftY,xprime+shiftX,1)=source(y,x, 1);
    warpedSrc(yprime+shiftY,xprime+shiftX,2)=source(y,x, 2);
    warpedSrc(yprime+shiftY,xprime+shiftX,3)=source(y,x, 3);
  end
  printf('Finished warping col: %d of %d\n', x, srcncols);
end
