% Script to communicate with IRB120 robot system
% Mark Whitty
% 140324
function c = sender(str)

% The robot's IP address.
% robot_IP_address = '192.168.2.1';
try
<<<<<<< HEAD:group_meeting 25_05_15/robot_studio .m file err/sender.m
<<<<<<< HEAD
robot_IP_address = '192.168.0.230';
=======
% robot_IP_address = '127.0.0.1';
robot_IP_address = '192.168.0.5';
>>>>>>> origin/master
=======
% robot_IP_address = '127.0.0.1';
robot_IP_address = '192.168.0.5';
>>>>>>> origin/master:group_meeting 25_05_15/robot_studio .m file/sender.m

% The port that the robot will be listening on. This must be the same as in
% your RAPID program.
robot_port = 1025;

% Open a TCP connection to the robot.
%str='wohoo';

socket = tcpip(robot_IP_address, robot_port);
set(socket, 'ReadAsyncMode', 'continuous');


fopen(socket);

% Check if the connection is valid.
if(~isequal(get(socket, 'Status'), 'open'))
    warning(['Could not open TCP connection A=to ', robot_IP_address, ' on port ', robot_port]);
    return;
end


fwrite(socket, str);


fclose(socket);
c = 'GREEN';
catch
%     errordlg('DISCONNECTED');
c='RED';
end

