function A = Filter(Im)
%Filter 
%   This is the filter I'm trying to make
im= imread(Im);
im2 = im;
    [X, Y, Z] = size( im2 );
    sub9 = zeros(3,3,3);
    s = 3;
    X1 = floor( X / s );
    Y1 = floor( Y / s );
    X1p = mod( X, s );
    Y1p = mod( Y, s );
    im2(2:X-1, 2:Y-1, 1:3) = getXyAv(im(
    
    
end
function A = getXyAv(subMat)
    %Pass in a matrix of predetermined scale, a submatrix, and this will
    %add up all of the values and return the average, in xy plane
    [X, Y, ~] = size(subMat);
    A = sum(sum(subMat, 1, 'native'), 2, 'native')/(X+Y);
end