function [c,state]=resume_func

    %to stop robot
    c1 = sender('S2');
    
    %to check and return status
    x=0;
    if strcmp(c1,'GREEN')==1
        x=x+1;
    end
    
    if x == 1
         c= 'GREEN';
         state = 'STOP';
    else
         c='RED'; 
    end
end