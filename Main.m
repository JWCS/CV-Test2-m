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
deltaIntenseFilter = 20;%48s@30,71s@25,117s@20, -5n -> +23n sec
maxDist = 10; %Even, max distance to search to next max
minLineLength = 20;
lineEndRange = 100;
meanKernel = double( ones( side, side ) ) ...
    / double( side^2 ); % sidexside mean kernel
Im = rot90( imread('H1.JPG'), -1 );
disp('Inputs:');disp('deltaIntenseFilter');disp(deltaIntenseFilter);
disp('maxDist');disp(maxDist);disp('minLineLength');disp(minLineLength);
disp('lineEndRange');disp(lineEndRange);
%image( ImGrad( FilterMeanV2(Im, meanKernel)))
%Im2 = FilterMeanV2( ...FilterMeanV2( ...
 %   ImGrad( ImGrad ( Im ) ), meanKernel );%, sobel );
%Im3 = ImGrad( FilterMeanV2( double(rgb2gray(Im)), meanKernel ) );
Im4 = uint8( ImGrad( FilterMeanV2( double(rgb2gray(Im)), meanKernel ) ) );
Im4( Im4 < deltaIntenseFilter ) = 0;
toc
[Lines, Lengths] = LineFind( Im4, maxDist, minLineLength, lineEndRange );
toc
%[ ~, LongestLineNo ] = max(Lengths);
%LongestLineCoord = Lines( :, :, LongestLineNo ); %[x1, y1; x2, y2; x3, ...] 
medianLineLength = median( Lengths );
meanLineLength = mean( Lengths );
image( Im4 )
hold on
for z = 1:size(Lines,3)-1
    plot( Lines(1:Lengths(z),2,z), Lines( 1:Lengths(z),1,z ), 'Color', 'k', 'LineWidth', 1 );
end
hold off
toc