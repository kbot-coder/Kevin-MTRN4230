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
    c1=sender(wave_1);
    pause(0.001);
    c2=sender('STRIO');
    x=0;
    if strcmp(c1,'GREEN')==1
        x=x+1;
    end
    if strcmp(c2,'GREEN')==1
        x=x+1;
    end
    if x == 2
        c= 'GREEN';
        pos_theta = strcat('[',Tro_ON_str,',',Tro_RUN_str,',',Vac_ON_str,',',...
       Vac_RUN_str,',',speed_str,']');
    else
        c='RED';
    end
end