function [pos, joint, IO] = Take_Rob_Status()
errs= 0;    % intialise the error value
socket = tcpip('127.0.0.1',1026);   % define the socket
set(socket, 'ReadAsyncMode', 'continuous');     % set the socket

while errs == 0 ;
    try
        fopen(socket);
        data = fgetl(socket);   % get the data from RAPID

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
        errs = 0;

    % a warning windows if there is any error
    catch err
        disp('ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ');  
        uiwait(errordlg('LOST CONNECTION. Please repair the source of error ','Connection Error'));
        try 
            fopen(socket);
            fclose(socket);
        catch err
            fclose(socket);
        end
        disp('RESTARTED');%
        errs = 1;
    end
end



