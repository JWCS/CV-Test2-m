function LineTrace( ReducedIm, maxDist )
%LINETRACE This should go through the image and trace out the objects
%   It would be dificult to have it only analyze the lines I want, and 
%   then to follow them in the right direction. 
    [X, Y] = size( ReducedIm );%also assuming ReducedIm is uint8
    seen = ones( X, Y );
    p1 = ReducedIm(1,1);
    p2 = p1;
    %p2 = ReducedIm(11,11);
    v = [10,10];
    onLine = true;
    for x = 1:X
        for y = 1:Y
            if seen( x, y ) ~= 0
                while onLine
                    p1 = p2;
                    C = Mat2Search( x, y, v, maxDist, X, Y );
                    x1 = C(1); y1 = C(2); x2 = C(3); y2 = C(4);
                    [xN, yN, allZ] = nextHigh( x1, y1, x2, y2, ...
                        seen.*ReducedIm);
                    p2 = [xN, yN];
                    seen( x1:x2, y1:y2 ) = 0;
                    if allZ || p1==p2
                        onLine = false;
                    else
                        
                    end

                end
            end
        end
    end

end
function [ xN, yN, allZ ] = nextHigh( x1, y1, x2, y2, Im )
%nextHigh Returns xN, yN point of the highest ~= 0 point in the mat
    
    
end