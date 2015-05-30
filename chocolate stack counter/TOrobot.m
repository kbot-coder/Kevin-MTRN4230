%version 2
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
    i=0;
    total = 0;
    cToT = '';
    while 1
        
        c1=sender(wave_1);
        disp('send1')
%       c1
        pause(0.5);
        r1=receive();
%         r1
        disp('recv1')
        pause(0.5);
        c2=sender(wave_2);
        disp('send2')
%         c2
        pause(0.5);
        r2=receive();
%         r2
        disp('recv2')
        pause(0.5);
        
        if strcmp(r1,'OKPM') == 1 && strcmp(r2,'OKIO') == 1
            total = total +1;
            break;
        
        elseif strcmp(r1,'OKPM') == 0 && strcmp(r2,'OKIO') == 1
            i=i+1;
        elseif strcmp(r1,'OKPM') == 1 && strcmp(r2,'OKIO') == 0
            i=i+1;
        elseif strcmp(c1,'RED') == 1 || strcmp(c2,'RED') == 1
            cToT = 'RED';
            break;
        elseif i == 4
            cTOT = 'RED';
            break;
            
        end
            
    end
    
    if strcmp(cToT,'RED') == 0
        
        while 1
            
            c3=sender('START');
            pause(0.5);
            r3=receive();
        
            if strcmp(r3,'OKST') == 1
                c = 'DONE';
                break;
                
            elseif strcmp(r3,'OKST') == 0
                
            
            end
        
        end
    elseif strcmp(cToT,'RED') == 1
        c= 'DC';
        
    end
    pos_theta = strcat('[',pos_x_str,',',pos_y_str,',',pos_z_str,',',num2str(quat_int(1)),',',num2str(quat_int(2)),',',num2str(quat_int(3)),',',...
        num2str(quat_int(4)),']');
%     x=0;
%     if strcmp(c1,'GREEN')==1
%         x=x+1;
%     end
%     if strcmp(c2,'GREEN')==1
%         x=x+1;
%     end
%     if strcmp(c3,'GREEN')==1
%         x=x+1;
%     end
%     
%     if x == 3
%         c= 'GREEN';
%         
%     else
%         c='RED';
%     end
% end