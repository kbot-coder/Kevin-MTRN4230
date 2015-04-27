clc;



% u = udp('google.com');
%  216.58.220.142    %straya
%  8.8.8.8           % google.com
%   173.194.116.175    %Europe
% 173.194.116.191     %africa



%% u : the socket
u   = udp('173.194.116.191', 65535);

% u   = udp('asdasdfafg123346tfhwt.com', 65535);


u.Timeout = 0.01;   % Set the timeout

data = 0;
while 1
    
    
    % Check if the connection exist
    try
        fopen(u);
    catch err
        uiwait(errordlg(err.message,'Connection Error'));
        continue;
    end

    data = fread(u);  

    fwrite(u,1212312312312331);


    fclose(u);
    if isempty(data)
        uiwait(errordlg(lastwarn,'Connection Error'));
        disp(data);
        continue
    else
        break;
    end
end

% % % if ispc
% % %     C = evalc('!ping -n 1 173.194.116.191 ');    
% % % elseif isunix
% % %     C = evalc('!ping -c 1 173.194.116.191 ');        
% % % end
% % % loss = regexp(C, '([0-9]*)%.*loss', 'tokens');
% % % connected = ~isempty(loss) && str2double(loss{1}{1})==0;


disp('----------END----------');