function cond = robSTAT

%initialize c to empty
    c= '';        
    c = receive_STAT();
    
    if strcmp(c,'GREEN')== 1 
        cond = 'GREEN';
   
    elseif strcmp(c,'YELLOW')==1
        cond = 'YELLOW';
    else
        cond = 'RED';
        errordlg('DISCONNECTED');
        
        
    end
       


