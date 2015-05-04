function [pos, joint, IO] = Take_Rob_Status()

socket = tcpip('127.0.0.1',1026);   % define the socket
set(socket, 'ReadAsyncMode', 'continuous');     % set the socket
socket.Timeout = 5;     % set the socket


% % % % % robot_IP_address = '127.0.0.1';
% % % % % robot_port = 1025;
% % % % % socket2 = tcpip(robot_IP_address, robot_port);
% % % % % set(socket2, 'ReadAsyncMode', 'continuous');


while 1
% % % % %         try
% % % % %             fopen(socket2);
% % % % %             fwrite(socket2, '0');
% % % % %             fclose(socket2);
% % % % %         catch err
% % % % %             uiwait(errordlg(err.message,'Connection Error 1'));
% % % % %             continue;
% % % % %         end    
       
    
        try
            fopen(socket);
        catch err
            uiwait(errordlg(err.message,'Connection Error'));
            continue;
        end

        data = fgetl(socket);   % get the data from RAPID
        
    if isempty(data)    
        uiwait(errordlg(lastwarn,'Connection Error -  No Data Received'));
        fclose(socket);
        continue;
    else

        openBracket = find(data == '[');    % find open bracket in the data
        closeBracket = find(data == ']');   % find close bracket in the data

        % extract and separate the data into three variables
        posStr = data(openBracket(1):closeBracket(1));
        jointStr = data(openBracket(2):closeBracket(2));
        IOStr = data(openBracket(3):closeBracket(3));

        % convert strings to double
        pos = str2num(posStr);
        joint = str2num(jointStr);
        IO = str2num(IOStr);

        fclose(socket);
        break;
    end

end

