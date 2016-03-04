
%Sample Test: 
clear;
%Calculate 2d gradient of xe^(-x2-y2)
v = -10:10;
[x,y] = meshgrid(v);
z = x .* exp(-x.^2 - y.^2);
[px,py] = gradient(z);
%Plot contour lines and vectors
contour(v,v,z)
hold on
quiver(v,v,px,py)
hold off