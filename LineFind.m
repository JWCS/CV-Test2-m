function [Lines, Lengths] = LineFind( ReducedIm, maxDist, minLineLength, lineEndRange )
%LINETRACE This should go through the image and trace out the objects
%   It would be dificult to have it only analyze the lines I want, and 
%   then to follow them in the right direction. 
    [X, Y] = size( ReducedIm );%also assuming ReducedIm is uint8
    seen = uint8( ReducedIm > 0 );
    %Lines = zeros(100, 2, 150, 'uint16');
    %Lengths = zeros(150, 1, 'uint8');
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
                    [x1, y1, x2, y2, struct, dir] = Mat2Search( p1, v, maxDist, X, Y );
                    x1=uint16(x1);y1=uint16(y1);x2=uint16(x2);y2=uint16(y2);
                    [xH, yH, allZ] = nextHigh( x1, y1, x2, y2, struct, dir, ...
                                        v, p1, maxDist, seen.*ReducedIm, lineEndRange);
                    p2 = [xH, yH];
                    seen( x1:x2, y1:y2 ) = 0; %Might be a better checkoff
                    %Room for improvement in line above, it clears extra +s
                    if allZ || (p2(1)-p1(1)==0 && p2(2)-p1(2)==0)
                        onLine = false;
                        if n < minLineLength %length < minLineLength
                            %Get rid of useless data
                            Lines(1:n, 1:2, lineNum) = 0;
                            lineNum = lineNum - 1;
                        else
                            %Add n to list of lengths for lines
                            Lengths(lineNum, 1) = uint16( n );
                            %seen( Lines(1, 1, lineNum), Lines(1, 2, lineNum)) =1;
                            %seen( Lines(n-1, 1, lineNum), Lines(n-1, 2, lineNum)) =1;
                        end
                    else
                        n = n + 1;
                        %Add p2 to list of points for this run
                        Lines(n, 1, lineNum) = uint16( xH ); 
                        Lines(n, 2, lineNum) = uint16( yH ); 
                    end
                end
            end
        end
    end
    
end %Have nextHigh  search Lines for an element that already fits into space
function [ xN, yN, allZ ] = nextHigh( x1, y1, x2, y2, struct, dir, v, ...
                                            p2, maxDist, Im, LineEndRange )
%nextHigh Returns xN, yN point of the highest ~= 0 point in the mat
    %C passes in this info from Mat2Search
    %disp('x1, y1, x2, y2, struct, dir, size(Im)');
    %disp(x1); disp(y1); disp(x2); disp(y2); disp(struct); disp(dir); disp(size(Im));
    attach = false;
    %[X1, Y1, X2, Y2, ~, ~]=Mat2Search(p2, v, LineEndRange, %could try this
    %later
    if exist('Lines','var')
        for n = 1:size(Lines,1)
            for z = size(Lines,3)
                if ((Lines(n,1,z)>=x1-LineEndRange &&...
                     Lines(n,1,z)<=x2+LineEndRange)&&...
                    (Lines(n,2,z)>=y1-LineEndRange &&...
                     Lines(n,2,z)<=y2+LineEndRange))
                        xN = Lines(n,1,z); yN = Lines(n,2,z);
                end
            end
        end
    end
    if exist('xN','var')&&exist('yN','var')&&attach
        %already wrote to xN and yN, so the rest doesn't execute
    else
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