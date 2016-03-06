function A = ImGrad( Im )
%ImGrad Image Gradient Magnitude
%   This returns a matrix of same mxn dimensions as givin, but each point
%   is the sum of the magnitudes of the differences of rgb dx dy values
    [X, Y, Z] = size( Im );
    %A = zeros( X, Y ); ML says bad practice to allocate here;
    B = zeros( X, Y, Z);
    B(2:(X-1), 2:(Y-1), 1:Z) =  ...
        abs( Im(3:X, 2:Y-1, 1:Z) - Im(1:X-2, 2:Y-1, 1:Z) )...
        + abs( Im(2:X-1, 3:Y, 1:Z) - Im(2:X-1, 1:Y-2, 1:Z) );
    A = sum(B,3,'native');
end