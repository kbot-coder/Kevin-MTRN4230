function cond = robBIND

%initialize c to empty
    c= '';
    
    c=sender('KNOK');
    
    %if succesfully send open receive
    pause(0.5);
    if strcmp(c,'GREEN') == 1
        
        c = receive();
    else
        c= 'RED';
    end
    
    
    if strcmp(c,'RED')== 1 
        cond = 'GREEN';
   
    elseif strcmp(c,'BUSY')==1
        cond = 'YELLOW';
    else
        cond = 'RED';
%         errordlg('DISCONNECTED');
        
        
    end
       


