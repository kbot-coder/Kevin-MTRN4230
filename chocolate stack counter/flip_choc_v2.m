% This function is used to flip the back facing chocolate.
% Input arguments:
% location_coordinate = the coordinate of the place to flip the chocolate.
% tool_coordinate     = the coordinate of the chocolate used to flip the
%                       chocolate.
% target_coordinate   = coordinate of the back facing chocolate that going to
%                       be flipped.
% tool_theta          = the orientation of the chocolate that going to be
%                       used to flip the choc
% target_theta        = the orientation of the target chocolate
% mode                = type 'RESET' to reset the tool

function flip_stat = flip_choc(location_x, location_y, tool_x, tool_y, tool_theta, target_x, target_y, target_theta, mode)
persistent tool_in_use;

chocThickness = 3;  % assume the chocolate thicknes is 3 mm
vel = 300; % set the velocity to 300 mm/s
location_theta = 0; % put the chocolate vertically (assuming theta = 0 is horizontal to the table)
% dist_thresh = 10;   % distance threshold
table_height = 147; % the height of the table from robot frame
x_offset = 50;
pause_time = 0.3;

% Reset the tool
if strcmp(mode, 'RESET')
    disp('Tool has been reset');
    tool_in_use = 0;
end
% just move the tool if the position is not in a correct location
% if (tool_x > location_x + dist_thresh || tool_x < location_x - dist_thresh) && ...
%    (tool_y > location_y + dist_thresh || tool_y < location_y - dist_thresh)
if ~tool_in_use
    TOrobot(tool_x, tool_y, table_height+ chocThickness, 0, 0, tool_theta);   % pick the chocolate that going to be used as a tool
    pause(pause_time);
    robot_status_loop;

    
    TOio(1,1,0,0,vel); % turn on vacuum;
    pause(pause_time);
    robot_status_loop;

    
    TOrobot(location_x, location_y, table_height + chocThickness, 0, 0, location_theta); % put the tool to empty location on the table
    pause(pause_time);
    robot_status_loop;

    
    TOio(0,0,0,0,vel); % turn off vacuum;
    pause(pause_time);
    robot_status_loop;

    tool_in_use = 1;    
end

pause(pause_time)
TOrobot(target_x, target_y, table_height + chocThickness, 0, 0, target_theta); % pick the target chocolate that going to be flipped
pause(pause_time);
robot_status_loop;


TOio(1,1,0,0,vel); % turn on vacuum;
pause(pause_time)
robot_status_loop;


TOrobot(location_x + x_offset, location_y, table_height + chocThickness + 2, 0, 0, 90); % put the chocolate horizontally on the edge of the tool
pause(pause_time);
robot_status_loop;


TOio(0,0,0,0,vel);  % turn off vacuum
pause(pause_time);
robot_status_loop;


TOrobot(location_x, location_y, table_height + chocThickness, 0, 0, 0); % grab the tool
pause(pause_time);
robot_status_loop;


TOio(1,1,0,0,vel); % turn on vacuum;
pause(pause_time);
robot_status_loop;


home(1) = location_x;
home(2) = location_y;
target(1) = target_x;
target(2) = target_y;
illustration(home,target,'MILK');

% lift and put back the chocolate to the location
sender('1');
pause(pause_time);
TOrobot(location_x + 50 , location_y, table_height + chocThickness + 40, 0, 0, 0);
pause(pause_time);
robot_status_loop;

TOrobot(location_x, location_y, table_height + chocThickness, 0, 0, 0);
pause(pause_time);
robot_status_loop;


sender('0');
flip_stat = 1;  % chocolate flipped


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
  home
  
  target
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
    plot(home(1),home(2),c0);
    hold on;
    plot([home(1),target(1)],[home(2),target(2)],'--');
    hold on;
end