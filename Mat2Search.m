function [x1, y1, x2, y2, struct, dir] = Mat2Search(  p, v, maxDist, maxX, maxY  )
%MAT2SEARCH This finds the Mat to search, based on givens; maxDist==even 
%   Detailed explanation goes here
    x = p(1); y = p(2);
    %disp('Mat2Search x y='); disp(x); disp(y);
    [struct, dir] = Case(v);
    if(struct==1)
        switch dir
            case 0
                x1 = x;
                y1 = y;
                x2 = x + maxDist;
                y2 = y + maxDist;
            case 1
                x1 = x - maxDist;
                y1 = y;
                x2 = x;
                y2 = y + maxDist;
            case 2
                x2 = x;
                y2 = y;
                x1 = x - maxDist;
                y1 = y - maxDist;
            case 3
                x1 = x;
                y2 = y;
                x2 = x + maxDist;
                y1 = y - maxDist;
        end
    elseif struct == 2
        if mod(dir,2)==0 %struct 2 extends along x axis
            if dir == 0 %Extends Right
                x1 = x;
                y1 = y - maxDist/2;
                x2 = x + maxDist;
                y2 = y + maxDist/2;
            else %Extends Left
                x1 = x - maxDist;
                y1 = y - maxDist/2;
                x2 = x;
                y2 = y + maxDist/2;                
            end
        else %extends along y axis
            if dir == 1 %Extends Up
                x1 = x - maxDist/2;
                y1 = y;
                x2 = x + maxDist/2;
                y2 = y + maxDist;
            else %Extends Down
                x1 = x - maxDist/2;
                y1 = y - maxDist;
                x2 = x + maxDist/2;
                y2 = y;
            end
        end
    elseif struct == 3
        x1 = x - maxDist/2;
        y1 = y - maxDist/2;
        x2 = x + maxDist/2;
        y2 = y + maxDist/2;
    end
    if x2 > maxX
        x2 = maxX;
    end
    if x2 < 1
        x2 = 1;
    end
    if x1 > maxX
        x1 = maxX;
    end
    if x1 < 1
        x1 = 1;
    end
    if y1 > maxY
        y1 = maxY;
    end
    if y1 < 1
        y1 = 1;
    end
    if y2 < 1
        y2 = 1;
    end
    if y2 > maxY
        y2 = maxY;
    end
end

function [struct, dir] = Case(v)
%Case Returns (Structure, dir), dir=0 means pi/4 or pi/2, per structure
%Struct 1 is to corner, 2 is to far side midpoint
    %Find type of structure and direction
    %For struct 1, dir(n) is pi/4 + n*pi/2
    %For struct 2, dir(n) is n*pi/2
    %For struct 3, dir = 0, a square centered at x,y
    if v(2) ~=0 && v(1) ~= 0
        m = double(v(2))/double(v(1));
        if abs( m ) > .5 && abs( m ) < 2
            struct = 1; %search out to corner of square
        else
            struct = 2; %search out to far side midpoint of square
        end
        if m > 0
           if v(1)>0
               dir = 0;
           else
               dir = 2;
           end
        else
            if v(1)>0
               dir = 3;
           else
               dir = 1;
           end
        end
    else
        struct = 2;
        if v(1) >0
            dir = 0;
        elseif v(1) <0
            dir = 2;
        elseif v(2) >0
            dir = 1;
        elseif v(2) <0
            dir = 3;
        elseif v(1) == 0 && v(2) == 0
            struct = 3;
            dir = 0;
        end
    end
end