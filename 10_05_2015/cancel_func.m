function [c,state]=cancel_func
        
        %to stop robot
        c1 = sender('S3');
        pause(0.1);
        c2 = sender('S2');
    
        %to check and return status
        x=0;
        if strcmp(c1,'GREEN')==1
            x=x+1;
        end
        if strcmp(c2,'GREEN')==1
            x=x+1;
        end
    
        if x == 2
            c= 'GREEN';
            state = 'STOP';
        else
            c='RED'; 
        end
    
end