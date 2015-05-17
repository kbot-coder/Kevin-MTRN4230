function clear_table(x_coor,y_coor)
    z_coor = 147;
    offset1 = 3;
    offset2 = 6;
    step = 0;
    adden = 0;
    n = 1;
    sender('1');
    pause(0.5);
    while n<4
        if n == 1
           offset = offset2;
        elseif n == 2
            offset = offset1;
        elseif n == 3
           adden = 100; 
        end
        
        step =step+1;
        if step == 1
            x_coor_new = x_coor;
            y_coor_new = y_coor;
            
        elseif step == 2
            x_coor_new = x_coor+100;
            y_coor_new = y_coor+adden;
            
        elseif step == 3
            x_coor_new = x_coor-100;
            y_coor_new = y_coor-adden;
           
        elseif step == 4
            x_coor_new = x_coor;
            y_coor_new = y_coor;
           
        elseif step == 5
            x_coor_new = x_coor-adden;
            y_coor_new = y_coor+100;
         
        elseif step == 6
            x_coor_new = x_coor+adden;
            y_coor_new = y_coor-100;
           
        end
        
%         TOio(1,1,0,0,300);
%         pause(0.5);
        TOrobot(x_coor_new,y_coor_new,(z_coor+offset),0,0,0);
        pause(0.5);
%         TOio(0,0,0,0,300);
%         pause(0.5);
        step
        z_coor+offset
        
        if step == 6
            n=n+1;
            step = 0;
        end
    end
    sender('0');
    pause(0.5);
end