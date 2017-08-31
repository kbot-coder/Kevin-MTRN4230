function c = stack_counter(s_mode,type)
persistent milk orange dark mint;
if strcmp(type,'')==1
   type = 'NULL'; 
end

if strcmp(s_mode,'WRITE')==1
    fprintf('WRITE\n');
    if strcmp(type,'MILK') == 1
       milk = milk+1;
    elseif strcmp(type,'ORANGE') == 1
       orange = orange+1;
    elseif strcmp(type,'DARK') == 1
       dark = dark+1;  
    elseif strcmp(type,'MINT') == 1
       mint = mint+1;  
    end

elseif strcmp(s_mode,'READ')==1
    fprintf('READ\n');
    if strcmp(type,'MILK') == 1
       c=milk;
    elseif strcmp(type,'ORANGE') == 1
       c= orange;
    elseif strcmp(type,'DARK') == 1
       c= dark;  
    elseif strcmp(type,'MINT') == 1
       c= mint;  
    end
    
elseif strcmp(s_mode,'RESET')==1
    fprintf('RESET\n');
    milk = 0;
    orange = 0;
    dark = 0;
    mint = 0;
    
elseif strcmp(s_mode,'DISPLAY')==1
    fprintf('DISPLAY\n');
    
    fprintf('MILK =      %i stack\n',milk);
    fprintf('ORANGE =    %i stack\n',orange);
    fprintf('DARK =      %i stack\n',dark);
    fprintf('MINT =      %i stack\n',mint);
    
else
    
    fprintf(2,'ERROR\n');
end


end