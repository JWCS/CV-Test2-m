%Main
%Reads picture from file, then finds the contour, the boundary of the main
%object in it, eg a hand. This class reads a matrix from a given filename
%and does the image handling. It will pass the matrix into the functions 
%that operate on the image. 
clear;
tic
%filterScale = 3; %by 3 mean
sobel = [1 2 1; 0 0 0; -1 -2 -1];
side = 3;
meanKernel = ones( side, side ) / side^2; % sidexside mean kernel
Im = imread('strawberry.jpg');

%image( ImGrad( FilterMeanV2(Im, meanKernel)))
Im2 = FilterMeanV2( ImGrad ( Im ), meanKernel );
image( Im2 )
hold on
%contour( Im2 )
hold off
toc
