%Get image data, put to raw, and playable
clear;
tic
A = imread('strawberry.jpg');
B = imread('LeftHand_2.png');
X = gradient( A );
Y = gradient( B );
AA = rgb2gray( A );
BB = rgb2gray( B );
%Graph4Quad(A, B, AA, BB);
toc