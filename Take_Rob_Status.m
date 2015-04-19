function Take_Rob_Status
robot_IP = '127.0.0.1';
robot_port = 1025;

socket = tcpip(robot_IP, robot_port);
set(socket, 'ReadAsyncMode', 'continuous');

fopen(socket);
listening = 1;
while listening
    data = fgetl(socket);
    fprintf(strcat(char(data),'\n'));
end

