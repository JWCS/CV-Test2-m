function [Lines, Lengths] = LineTrace( ReducedIm, maxDist )
%LINETRACE This should go through the image and trace out the objects
%   It would be dificult to have it only analyze the lines I want, and 
%   then to follow them in the right direction. 
    [X, Y] = size( ReducedIm );%also assuming ReducedIm is uint8
    seen = uint8( ReducedIm > 0 );
    %p2 = ReducedIm(11,11);
    lineNum = 0;
    for x = 1:X
        for y = 1:Y
            if seen( x, y ) ~= 0
                p1 = [x,y];
                p2 = p1;
                n = 0;
                lineNum = lineNum + 1;
                onLine = true;
                while onLine
                    v = p2 - p1;
                    p1 = p2;
                    C = Mat2Search( p2, v, maxDist, X, Y );
                    [xN, yN, allZ] = nextHigh( C, p2, maxDist, seen.*ReducedIm);
                    p2 = [xN, yN];
                    seen( C(1):C(3), C(2):C(4) ) = 0; %Might be a better checkoff
                    if allZ || (p2(1)-p1(1)==0 && p2(2)-p1(2)==0)
                        onLine = false;
                        %Add n to list of lengths for lines
                        Lengths(lineNum) = n;
                    else
                        n = n + 1;
                        %Add p2 to list of points for this run
                        Lines(n, 1, lineNum) = xN; 
                        Lines(n, 2, lineNum) = yN; 
                    end
                end
            end
        end
    end
    
end
function [ xN, yN, allZ ] = nextHigh( C, p2, maxDist, Im )
%nextHigh Returns xN, yN point of the highest ~= 0 point in the mat
    %C passes in this info from Mat2Search
    x1 = uint8(C(1)); y1 = uint8(C(2)); x2 = uint8(C(3)); y2 = uint8(C(4)); 
    struct = C(5); dir = C(6);
    Im1Col = Im(x1:x2,y1:y2); %Sub mat to search of Im
    [ ~, I ] = max(Im1Col(:)); %Indices fo the max of above
    [ px, py ] = ind2sub( size( Im1Col ), I ); %Indices to subscripts
    [xN, yN] = searchMat2Im(p2, px, py, maxDist, struct, dir);%To Coordinates
    if sum(sum(Im1Col),2) == 0
        allZ = true;
    else
        allZ = false;
    end
end
function [pX, pY] = searchMat2Im( p0, px, py, maxDist, struct, dir)
    if struct == 1
        if dir == 0
            pX = p0(1) + px - 1;
            pY = p0(2) + py - 1;
        elseif dir == 1
            pX = p0(1) + px - maxDist;
            pY = p0(2) + py - 1;
        elseif dir == 2
            pX = p0(1) + px - maxDist;
            pY = p0(2) + py - maxDist;
        elseif dir == 3
            pX = p0(1) + px - 1;
            pY = p0(2) + py - maxDist;
        end
    elseif struct == 2
        if dir == 0
            pX = p0(1) + px - 1;
            pY = p0(2) + py - maxDist/2;
        elseif dir == 1
            pX = p0(1) + px - maxDist/2;
            pY = p0(2) + py - 1;
        elseif dir == 2
            pX = p0(1) + px - maxDist;
            pY = p0(2) + py - maxDist/2;
        elseif dir == 3
            pX = p0(1) + px - maxDist/2;
            pY = p0(2) + py - maxDist;
        end
    elseif struct == 3
        pX = p0(1) + px - maxDist/2;
        pY = p0(2) + py - maxDist/2;
    end
end