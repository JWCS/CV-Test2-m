function A = subMat(Mat, x, y, range)
%subMat Pass in a matrix, coordinate, and range to take a submatrix of
    %range must be odd, range is the side of square matrix subMat ...
    %with coordinate x,y at the center; Mat must be 2D;
    %given r = (range - 1)/2, x,y must be each r spaces or more from edge
    r = (range - 1) / 2; %radius r
    A(1:range, 1:range ) = ...
        Mat( x - r : x + r, y - r : y + r, 1);
end