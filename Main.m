%Main
%Reads picture from file, then finds the contour, the boundary of the main
%object in it, eg a hand. This class reads a matrix from a given filename
%and does the image handling. It will pass the matrix into the functions 
%that operate on the image. 
clear;
tic
filterScale = 3; %by 3 mean
Im = imread('strawberry.jpg');
image( ImGrad( FilterMeanV2(Im, )))
toc