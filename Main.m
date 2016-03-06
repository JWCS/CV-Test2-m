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
meanKernel = double( ones( side, side ) ) ...
    / double( side^2 ); % sidexside mean kernel
Im = rot90( imread('H1.jpg'), -1 );

%image( ImGrad( FilterMeanV2(Im, meanKernel)))
%Im2 = FilterMeanV2( ...FilterMeanV2( ...
 %   ImGrad( ImGrad ( Im ) ), meanKernel );%, sobel );
Im3 = ImGrad( FilterMeanV2( double(rgb2gray(Im)), meanKernel ) );
Im4 = uint8(Im3);%(1420:1480,940:1010));
Im4(Im4<6) = 0;
image( Im4 )
hold on
%contour( Im3, 1 )
hold off
toc
