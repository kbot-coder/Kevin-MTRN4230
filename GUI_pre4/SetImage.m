%-------------------Video & Image Acquisition Setting----------------------

function [imHeight,imWidth, nBands] = SetImage(video1,video2)

video1.FramesPerTrigger = 1;                        % set number frame per trigger
video1.ReturnedColorspace = 'rgb';                  % set colorspace of the video image as rgb
triggerconfig(video1 , 'manual');                   % Set triger video as manual so video will on until user stop it
vidRes1 = get(video1 , 'VideoResolution');           % Get video resolution
imWidth(1) = vidRes1(1); imHeight(1) = vidRes1(2);          % Get size of the video image
nBands(1) = get(video1 , 'NumberOfBands'); 

video2 .FramesPerTrigger = 1;                 % set number frame per trigger
video2 .ReturnedColorspace = 'rgb';           % set colorspace of the video image as rgb
triggerconfig(video2 , 'manual');             % Set triger video as manual so video will on until user stop it
vidRes2 = get(video2 , 'VideoResolution');     % Get video resolution
imWidth(2) = vidRes2(1); imHeight(2) = vidRes2(2);          % Get size of the video image
nBands(2) = get(video2 , 'NumberOfBands');

return

 