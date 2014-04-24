function foo = backinterp(src, dest, h)




[a, b, c] = size(src);
[xi, yi] = meshgrid(1:a, 1:b);
h = inv(h); %TAKE INVERSE FOR USE WITH INTERP2
xx = (h(1,1)*xi+h(1,2)*yi+h(1,3))./(h(3,1)*xi+h(3,2)*yi+h(3,3));
yy = (h(2,1)*xi+h(2,2)*yi+h(2,3))./(h(3,1)*xi+h(3,2)*yi+h(3,3));

foo(:,:,1) = interp2(src(:,:,1), xx, yy); % red
foo(:,:,2) = interp2(src(:,:,2), xx, yy); % green
foo(:,:,3) = interp2(src(:,:,3), xx, yy); % blue

[y, x, layers] = size(dest);
[ysrc, xsrc, lay] = size(src);


for i = 1:min(x,xsrc)
  for j = 1:min(y,ysrc)
    for layer = 1:3
      if(foo(i,j,layer) != 0)
        dest(i,j,layer) = foo(i,j,layer);
      end
    end
  end
end

foo = dest;
