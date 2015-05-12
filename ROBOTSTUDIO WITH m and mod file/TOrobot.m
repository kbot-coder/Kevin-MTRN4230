function [c,pos_theta] = TOrobot(pos_x_int,pos_y_int,pos_z_int,thetaX_int,thetaY_int,thetaZ_int)
    %convert angle to quat
    quat_int=convertangle(thetaX_int,thetaY_int,thetaZ_int);
    
    %convert to string
    pos_x_str = int2str(pos_x_int);
    pos_y_str = int2str(pos_y_int);
    pos_z_str = int2str(pos_z_int);
     
    %put in correct format and sent to  robotstudio
    wave_1 = strcat('[',pos_x_str,',',pos_y_str,',',pos_z_str,']');
    wave_2 = strcat('[',num2str(quat_int(1)),',',num2str(quat_int(2)),',',num2str(quat_int(3)),',',...
        num2str(quat_int(4)),',','0,0]');
    c1=sender(wave_1);
    pause(0.5);
    c2=sender(wave_2);
    pause(0.5);
    c3=sender('START');
    x=0;
    if strcmp(c1,'GREEN')==1
        x=x+1;
    end
    if strcmp(c2,'GREEN')==1
        x=x+1;
    end
    if strcmp(c3,'GREEN')==1
        x=x+1;
    end
    if x == 3
        c= 'GREEN';
        pos_theta = strcat('[',pos_x_str,',',pos_y_str,',',pos_z_str,',',num2str(quat_int(1)),',',num2str(quat_int(2)),',',num2str(quat_int(3)),',',...
        num2str(quat_int(4)),']');
    else
        c='RED';
    end
end