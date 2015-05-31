function clear_table()
    z_coor = 147;
    offset = 6;
%     offset2 = 12;
    step = 0;
    adden = 0;
    end_x = 175;
    end_y = 0;
    
    n = 1;
    sender('0');
    pause(0.5);
    while step<4
%         if n == 1
%            offset = offset1;
%         elseif n == 2
%             offset = offset1;
%         elseif n == 3
%            adden = 100; 
%         end
        
        step =step+1;
        if step == 1
            x_coor_new = 175;
            y_coor_new = -520;
            
        elseif step == 2
            x_coor_new = 185;
            y_coor_new = -510;
            
        elseif step == 3
            x_coor_new = 195;
            y_coor_new = -500;
           
        elseif step == 4
            x_coor_new = 205;
            y_coor_new = -490;
           
%         elseif step == 5
%             x_coor_new = x_coor-adden;
%             y_coor_new = y_coor+100;
%          
%         elseif step == 6
%             x_coor_new = x_coor+adden;
%             y_coor_new = y_coor-100;
           
        end
        
%         TOio(1,1,0,0,300);
%         pause(0.5);
        c=TOrobot(x_coor_new,y_coor_new,(z_coor+offset),0,0,0);
        if strcmp(c,'DONE');
            waiting;
            
            TOio(1,1,0,0,300);
            pause(1.5);
            
            sender('1');
            pause(0.5);
            
            c=TOrobot(end_x+(step-1)*10,end_y,(z_coor+offset),0,0,0);
            if strcmp(c,'DONE');
                waiting;
                
                TOio(0,0,0,0,300);
                pause(1.5);
                sender('0');
                pause(0.5);
%         TOio(0,0,0,0,300);
%         pause(0.5);
        end
%         step
%         z_coor+offset
%         
%         if step == 6
%             n=n+1;
%             step = 0;
%         end
%     end
%     sender('0');
%     pause(0.5);
    end
    end
end

