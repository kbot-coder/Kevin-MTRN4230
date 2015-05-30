% Script to communicate with IRB120 robot system
% Mark Whitty
% 140324

function c = receive_STAT()
try
% The robot's IP address.
% robot_IP_address = '192.168.2.1';

% robot_IP_address = '192.168.0.230';

robot_IP_address = '127.0.0.1';
% robot_IP_address = '192.168.0.5';

% robot_IP_address = '127.0.0.1';
% robot_IP_address = '192.168.0.5';
% >>>>>>> origin/master:group_meeting 25_05_15/robot_studio .m file/receive_STAT.m

% The port that the robot will be listening on. This must be the same as in
% your RAPID program.
robot_port = 1028;

% Open a TCP connection to the robot.

socket = tcpip(robot_IP_address, robot_port);
set(socket, 'ReadAsyncMode', 'continuous');

fopen(socket);

% Check if the connection is valid.
if(~isequal(get(socket, 'Status'), 'open'))
    warning(['Could not open TCP connection A=to ', robot_IP_address, ' on port ', robot_port]);
    return;
end

%request special string

c1 = char(fread(socket,4))';

fclose(socket);
%ensure that the special code are received
if strcmp(c1,'REDE') == 1
    
    c = 'GREEN';
elseif strcmp(c1,'BUSY') == 1
    c= 'YELLOW';
    
else
    c='RED';
end

catch
    %if error
    c= 'RED';
end

