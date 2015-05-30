% Script to communicate with IRB120 robot system
% Mark Whitty
% 140324

function c = receive()
try
% The robot's IP address.
% robot_IP_address = '192.168.2.1';

% robot_IP_address = '192.168.0.230';

% robot_IP_address = '127.0.0.1';
% robot_IP_address = '192.168.0.5';
robot_IP_address = '127.0.0.1';
% robot_IP_address = '192.168.0.5';


% The port that the robot will be listening on. This must be the same as in
% your RAPID program.
robot_port = 1027;

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
c=c1;

catch
    %if error
    c= 'RED';
end

