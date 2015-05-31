function [video1, video2, status]=ConnectToCameraAuto()

try
    % For windows
    video1  = videoinput('winvideo',2,'RGB24_1600X900');         % Input video 1 from table camera
    video2  = videoinput('winvideo',1,'RGB24_1600X900');         % Input video 2 from conveyor camera
    status  = 1;                                % make the connection status = 1 ---> Connected
catch
    try
        % For macs.
        video1  = videoinput('macvideo',1);     % Input video 1 from table camera
        video2  = videoinput('macvideo',2);     % Input video 2 from conveyor camera
        status  = 1;                            % make the connection status = 1 ---> Connected
    catch
        video1  = [];     % No input camera
        video2  = [];     % No input camera
        status  = 0;      % make the connection status = 0 ---> NOT Connected
%         errordlg('No camera available');   
        disp('No camera detected......');
        disp('Using sample images');
    end
end

return
    