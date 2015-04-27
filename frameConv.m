% This function converts the robot frame to table frame.
% Input: Coordinates [X,Y,Z] in respect to table frame.
% Output: Coordinates [X,Y,Z] in respect to robot frame and reachability status.
function ret = frameConv(xTab, yTab, zTab)
    % list the offset between the robot frame and the table frame in mm
    x_offs = 175;
    y_offs = 0;
    z_offs = 147;
    
    % add the coordinate in table frame with the offset.
    xRob = xTab + x_offs;
    yRob = yTab + y_offs;
    zRob = zTab + z_offs;
    
    x_min = 0;
    x_max = 548.6;
    y_min = -520;
    y_max = 520;
    if xRob > 129
        z_min = 147;
    else
        z_min = 22;
    end
    z_max = 167;
    
    if (xRob < x_min || xRob > x_max) || ...
       (yRob < y_min || yRob > y_max) || ...
       (zRob < z_min || zRob > z_max)
   
        reachStats = 0;
    else
        reachStats = 1;
    end
    
    ret = [xRob, yRob, zRob, reachStats];