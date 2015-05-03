function cond = robBIND

%initialize c to empty
    c= '';
    
    c=sender('KNOK');
    c
    %if succesfully send open receive
    pause(0.001);
    if strcmp(c,'GREEN') == 1
        fprintf('gagaga\n')
        c = receive();
    else
        c= 'RED';
    end
    c
    
    if strcmp(c,'GREEN')== 1 
        cond = 'GREEN';
   
    else
        cond = 'RED';
        errordlg('DISCONNECTED');
        
        
    end
       


