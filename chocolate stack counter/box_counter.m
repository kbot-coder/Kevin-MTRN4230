function c=box_counter(s_mode,type,pos_coor)
persistent box;

if strcmp(s_mode,'WRITE')==1
    if strcmp(pos_coor,'PACK')
        box_num = str2num(type);
        box(box_num,1)= box(box_num,1)+1;
        
        if box(box_num,1) == 5
            
            box(box_num,2) = box(box_num,2)+1;
            box(box_num,1)=1;
        end
    elseif strcmp(pos_coor,'UNPACK')
        box_num = str2num(type);
        box(box_num,1)= box(box_num,1)-1;
        
        if box(box_num,1) == 0
            
            box(box_num,2) = box(box_num,2)-1;
            box(box_num,1)=4;
        end
    end
        
        
elseif strcmp(s_mode,'READ')==1
        number_read = str2num(type);
        length_1_4 = 80.25;
        length_2_3 = 26.75;
        
        if box(number_read,1) == 1 || box(number_read,1) == 4
            length = length_1_4;
            
            if box(number_read,1) == 1
                pos_min = 1;
            else
                pos_min = -1;
            end
            
        elseif box(number_read,1) == 2 || box(number_read,1) == 3
            length = length_2_3;
            
            if box(number_read,1) == 2
                pos_min = 1;
            else
                pos_min = -1;
            end
        end
        
        xnew_coor = box(number_read,3) + pos_min*length*sin(box(number_read,6));
        ynew_coor = box(number_read,4) + pos_min*length*cos(box(number_read,6));
        znew_coor = box(number_read,5) + box(number_read,2)*3;
        c = [xnew_coor,ynew_coor,znew_coor,box(number_read,6)+90]; 
        c
elseif strcmp(s_mode,'RESET')==1
    box = [];
       
elseif strcmp(s_mode,'MAKE')==1     
    
    number_box = str2num(type);
    i=0;
    
    while i<number_box
       
        
        i=i+1;
        %row 1 = stack pos there are 1 to 4
        box(i,1) = 1;
        %row 2 = the number of stack
        box(i,2) = 1;
        
        %coordinate of the box
        box(i,3) = 0;   %x
        box(i,4) = 0;   %y  
        box(i,5) = 0;   %z
        box(i,6) = 0;   %theta
        
    end
    
elseif strcmp(s_mode,'SETBOX')==1
    number_set = str2num(type);
    pos_coor_int = str2num(pos_coor);
    box(number_set,3) = pos_coor_int(1,1);
    box(number_set,4) = pos_coor_int(1,2);
    box(number_set,5) = pos_coor_int(1,3);
    box(number_set,6) = pos_coor_int(1,4);

elseif strcmp(s_mode,'SETCHOC')==1
    number_set = str2num(type);
    pos_coor_int = str2num(pos_coor);
    box(number_set,1) = pos_coor_int(1,1);
    box(number_set,2) = pos_coor_int(1,2);
    
elseif strcmp(s_mode,'DISPLAY')==1
    
    box
    
end
end