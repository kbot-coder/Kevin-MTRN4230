% Script to communicate with IRB120 robot system
% Mark Whitty
% 140324
function c = sender(str)

% The robot's IP address.
% robot_IP_address = '192.168.2.1';
try
robot_IP_address = '127.0.0.1';

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

