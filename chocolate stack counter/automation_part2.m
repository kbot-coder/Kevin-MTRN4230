function automation_part2(c)
    
    milk_home = [200,100,0];
    dark_home = [200,200,0];
    orange_home = [200,300,0];
    mint_home = [200,400,0];
    
    stack_counter('RESET','');
%     c = point_maker(N);
    [col,~] = size (c);
    disp(c);
    i=0;
    
    while i<(col)
        i=i+1; 
        if c(i,4) == 1
            flavour = 'MILK';
            c1 = milk_home;
        elseif c(i,4) == 2
            flavour = 'DARK';
            c1 = dark_home;
        elseif c(i,4) == 3
            flavour = 'ORANGE';
            c1 = orange_home;
        elseif c(i,4) == 4
            flavour = 'MINT';
            c1 = mint_home;
        end
        fprintf('to target\n');
        [status1,target_coor] = TOrobot(c(i,1),c(i,2),150,0,0,c(i,3));
        pause(0.5);
        robot_status_loop;
        pause(0.5);
        status2 = TOio(1,1,0,0,300);
        pause(0.5);
        robot_status_loop;
        pause(0.5);
        [status1,target_coor] = TOrobot(c(i,1),c(i,2),150+50,0,0,c(i,3));
        pause(0.5);
        robot_status_loop;
        num_stack = stack_counter('READ',flavour);
        offset = 150 + 3*num_stack;
        fprintf('to home ');
        fprintf(flavour);
        fprintf(' with %i stacks\n',num_stack);
        [status3,home_coor] = TOrobot(c1(1,1),c1(1,2),offset,0,0,c1(1,3));
        pause(0.5);
        robot_status_loop;
        status4 = TOio(0,0,0,0,300);
        stack_counter('WRITE',flavour);
        pause(0.5);
        robot_status_loop;
        pause(0.5);
       [status5,home_coor] = TOrobot(c1(1,1),c1(1,2),offset+50,0,0,c1(1,3));
       pause(0.5);
        if strcmp(status1,'RED') == 1 || strcmp(status2,'RED') == 1 || strcmp(status3,'RED') == 1 ||strcmp(status4,'RED') == 1||strcmp(status5,'RED') == 1
            errordlg('DC_status1-4');
            break;
        end
        illustration(home_coor,target_coor,flavour);
    end
    
function robot_status_loop()
        exit =0;
        while exit == 0
            status_rob = robBIND;
            pause(0.5);
            if strcmp(status_rob,'GREEN') == 1
                break;
            elseif strcmp(status_rob ,'YELLOW') == 1
                
            elseif strcmp(status_rob,'RED') == 1   
                errordlg('DC');
            end
        end
    end
end

function illustration(home,target,colour)
    target_int = str2num(target);
    home_int = str2num(home);
    if strcmp(colour,'MILK')==1
            c0 ='b*';
    elseif strcmp(colour,'DARK')==1
            c0 = 'k*';
    elseif strcmp(colour,'ORANGE')==1
            c0 = 'y*';
    elseif strcmp(colour,'MINT')==1
            c0 = 'g*';
    end
    figure(1)
    hold on;
    plot(home_int(1),home_int(2),c0);
    hold on;
    plot([home_int(1),target_int(1)],[home_int(2),target_int(2)],'--');
    hold on;
end