function [pos, joint, IO] = Take_Rob_Status()
errs= 0;    % intialise the error value
socket = tcpip('192.168.2.1',1026);   % define the socket
set(socket, 'ReadAsyncMode', 'continuous');     % set the socket
% socket.Timeout = 5;

connected = 0;
while connected == 0
    if ispc
        C = evalc('!ping -n 1 192.168.2.1');    
    elseif isunix
        C = evalc('!ping -c 1 192.168.2.1');        
    end
    loss = regexp(C, '([0-9]*)%.*loss', 'tokens');
    connected = ~isempty(loss) && str2double(loss{1}{1})==0;
    if ~connected
        disp('ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ');  
        uiwait(errordlg('LOST CONNECTION. Please repair the source of error ','Connection Error')); 
        pause('1');
        disp('RESTARTED');  
    end  
end



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

end



