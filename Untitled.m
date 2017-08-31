% Script to communicate with IRB120 robot system
% Mark Whitty
% 140324
function Untitled

% The robot's IP address.
% robot_IP_address = '192.168.2.1';
robot_IP_address = '127.0.0.1';

% The port that the robot will be listening on. This must be the same as in
% your RAPID program.
robot_port = 1025;

% Open a TCP connection to the robot.
str='wohoo';
while strcmp(str,'STOP') ~= 1
socket = tcpip(robot_IP_address, robot_port);
set(socket, 'ReadAsyncMode', 'continuous');
fopen(socket);

% Check if the connection is valid.
if(~isequal(get(socket, 'Status'), 'open'))
    warning(['Could not open TCP connection A=to ', robot_IP_address, ' on port ', robot_port]);
    return;
end

% Send a sample string to the server on the robot.
% for i=1:30

prompt = 'bitchhhhhhhhh pleaseeeee: ';
str = input(prompt,'s');
 

    
% POS = [A,B,C,D,E,F];
% robjoint = int2str(POS);
% posi = [A,B,C];
% pos = num2str(posi); 
% pos = strcat('[',int2str(A),',',int2str(B),',',int2str(C),']')

% jointpos = strcat('[',int2str(A),',',int2str(B),',',int2str(C),',',int2str(D),',',int2str(E),',',int2str(F),']')
fwrite(socket, str);

% Read a line from the socket. Note the line feed appended to the message in the RADID sample code.
% data = fgetl(socket);

% Print the data that we got.
% fprintf(char(data));
fclose(socket);
end
% Close the socket.
