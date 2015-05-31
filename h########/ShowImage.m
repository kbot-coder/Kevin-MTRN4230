%-------------------Video & Image Acquisition Button-----------------------

function [imHeight,imWidth, nBands] = ShowImage(video1,video2)
video1.FramesPerTrigger = 1;                        % set number frame per trigger
video1.ReturnedColorspace = 'rgb';                  % set colorspace of the video image as rgb
triggerconfig(video1 , 'manual');                   % Set triger video as manual so video will on until user stop it
vidRes = get(video1 , 'VideoResolution');           % Get video resolution
imWidth(1) = vidRes(1); imHeight(1) = vidRes(2);    % Get size of the video image
nBands(1) = get(video1 , 'NumberOfBands'); 

video2.FramesPerTrigger = 1;                        % set number frame per trigger
video2.ReturnedColorspace = 'rgb';                  % set colorspace of the video image as rgb
triggerconfig(video2 , 'manual');                   % Set triger video as manual so video will on until user stop it
vidRes = get(video2 , 'VideoResolution');           % Get video resolution
imWidth(2) = vidRes(1); imHeight(2) = vidRes(2);    % Get size of the video image
nBands(2) = get(video2 , 'NumberOfBands'); 

return

function StopIm_Callback(hObject, eventdata, handles)
handles.vid2 .FramesPerTrigger = 1;                 % set number frame per trigger
handles.vid2 .ReturnedColorspace = 'rgb';           % set colorspace of the video image as rgb
triggerconfig(handles.vid2 , 'manual');             % Set triger video as manual so video will on until user stop it
vidRes = get(handles.vid2 , 'VideoResolution');     % Get video resolution
imWidth = vidRes(1); imHeight = vidRes(2);          % Get size of the video image
nBands = get(handles.vid2 , 'NumberOfBands');
axes(handles.TableCam);                             % set axes TableCam for showing video 2
hImage2 = image(zeros(imHeight, imWidth, nBands), ... % set image frame as a the size of video image as a base for showing 
    'parent', handles.TableCam);                    % video image
preview(handles.vid2,hImage2);  