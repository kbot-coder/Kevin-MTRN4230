function isReachable = reachCheck(xRob, yRob, zRob)
    
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
    
    isReachable = [xRob, yRob, zRob, reachStats];