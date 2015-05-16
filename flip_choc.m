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

function flip_stat = flip_choc(location_x, location_y, tool_x, tool_y, tool_theta, target_x, target_y, target_theta)

flip_stat = 0;    % set the initial status (i.e. chocolate has not been flipped yet)
chocThickness = 3;  % assume the chocolate thicknes is 3 mm
vel = 300; % set the velocity to 300 mm/s
location_theta = 0; % put the chocolate vertically (assuming theta = 0 is horizontal to the table)
dist_thresh = 10;   % distance threshold

y_offset = 50;

% just move the tool if the position is not in a correct location
if (tool_x > location_x + dist_thresh || tool_x < location_x - dist_thresh) && ...
   (tool_y > location_y + dist_thresh || tool_y < location_y - dist_thresh)
   
    TOrobot(tool_x, tool_y, chocThickness, 0, 0, tool_theta);   % pick the chocolate that going to be used as a tool
    TOio(1,1,0,0,vel); % turn on vacuum;
    TOrobot(location_x, location_y, chocThickness, 0, 0, location_theta); % put the tool to empty location on the table
    TOio(0,0,0,0,vel); % turn off vacuum;
    
end

TOrobot(target_x, target_y, chocThickness, 0, 0, target_theta); % pick the target chocolate that going to be flipped
TOio(1,1,0,0,vel); % turn on vacuum;
TOrobot(location_x, location_y + y_offset, chocThickness+2, 0, 0, 90); % put the chocolate horizontally on the edge of the tool
TOio(0,0,0,0,vel);  % turn off vacuum
TOrobot(TOrobot(location_x, location_y, chocThickness, 0, 0, 0); % grab the tool
TOio(1,1,0,0,vel); % turn on vacuum;

% lift and put back the chocolate to the location
TOrobot(location_x, location_y, chocThickness, 0, 0, 10);
pause(0.5);
TOrobot(TOrobot(location_x, location_y, chocThickness, 0, 0, 0);

flip_stat = 1;  % chocolate flipped
