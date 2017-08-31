function [c,pos_theta] = TOio(Tro_ON_int,Tro_RUN_int,Vac_ON_int,Vac_RUN_int,speed_int)
    
    %convert to string
    Tro_ON_str = int2str(Tro_ON_int);
    Tro_RUN_str = int2str(Tro_RUN_int);
    Vac_ON_str = int2str(Vac_ON_int);
    Vac_RUN_str = int2str(Vac_RUN_int);
    speed_str = int2str(speed_int);
    
    %put in correct format and sent to  robotstudio
    wave_1 = strcat('[',Tro_ON_str,',',Tro_RUN_str,',',Vac_ON_str,',',...
       Vac_RUN_str,',',speed_str,',0]');
    cToT='';
    i=0;
    while 1
        c1=sender(wave_1);
        disp('send1')
        pause(0.5);
        r1=receive();
        disp('recv1')
        pause(0.5);
        
        if strcmp(r1,'OKIO') == 1
            break;
        elseif strcmp(c1,'RED') == 1
            cToT = 'RED';
            break;
            
        else
            cToT = 'RED';
        end
        
    end
    
    if strcmp(cToT,'RED') == 0
        
        while 1
            
            c2=sender('STRIO');
            pause(0.5);
            r2=receive();
            
            if strcmp(r2,'OKSI') == 1
                c = 'DONE';
                break;
                
            elseif strcmp(r2,'OKST') == 0
                
            
            end
            
        end
        
    elseif strcmp(cToT,'RED') == 1
        
        c='DC';
        
        
    end
%     c2=sender('STRIO');
%     x=0;
%     if strcmp(c1,'GREEN')==1
%         x=x+1;
%     end
%     if strcmp(c2,'GREEN')==1
%         x=x+1;
%     end
%     if x == 2
%         c= 'GREEN';
%         pos_theta = strcat('[',Tro_ON_str,',',Tro_RUN_str,',',Vac_ON_str,',',...
%        Vac_RUN_str,',',speed_str,']');
%     else
%         c='RED';
%     end
% end