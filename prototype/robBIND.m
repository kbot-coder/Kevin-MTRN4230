function robBIND


listening = 1;
time =1;

while listening == 1
    time = time +1
    if time == 2
        
    else
        pause(5);
    end
    sender('KNOK');
    %fclose(socket);  
    pause(1);
    c='0';
    c = receive();
    
    if strcmp(c,'HERE')== 1 
        
        fprintf('CONNECTED\N');
       
        listening =1;
    else
       
        errordlg('DISCONNECTED');
        listening = 0;
        
    end
    
   
    
       

end
