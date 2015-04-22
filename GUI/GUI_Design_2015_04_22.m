% DONT TOUCH ANYTHING INSIDE THE BOX HERE
%==========================================================================
function varargout = GUI_Design_2015_04_22(varargin)

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_Design_2015_04_22_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_Design_2015_04_22_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout 
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT
% ========================================================================


%--------------------------------------------------------------------------
% Executes just before GUI_Design_2015_04_22 is made visible.
%--------------------------------------------------------------------------
function GUI_Design_2015_04_22_OpeningFcn(hObject, eventdata, handles, varargin)
% Set All Handles Variable
handles.output = hObject;

%VALUES
handles.moving      = 0;
handles.position    = [ 0,0,0]; 
handles.joint       = [ 0,0,0,0,0,0];
handles.Speed ='10';
handles.pause=0;

% Initial Input Output
handles.CRun        ='0';   
handles.CDir        ='0';
handles.Sol         ='0';
handles.Vac         ='0';
handles.Connect     = 0;

% Managing Variable handles
handles.s   = [0,0];
handles.X   = '0'; 
handles.Y   = '0';
handles.Z   = '0';
handles.CJ1 ='0'; 
handles.CJ2 ='0';
handles.CJ3 ='0';
handles.CJ4 ='0';
handles.CJ5 ='0';
handles.CJ6 ='0';
handles.IOR = [0,0,0,0,0]; %the last value must be 0

% Managing Axis handles
set(handles.axes3,'Visible','On');
set(handles.axes3, 'Xlim', [-800,800], 'YLim', [0 900]);
set(handles.axes3,'xtick',[],'ytick',[]);
set(handles.ConvCam,'xtick',[],'ytick',[]);
set(handles.TableCam,'xtick',[],'ytick',[])
set(handles.axes4,'xtick',[],'ytick',[])

axes(handles.axes5);
imshow(imread('preview.jpg'));

%Managing Video handles
handles.vid1  = videoinput('macvideo',1);
% handles.vid2  = videoinput('macvideo',2);
% handles.vid1  = videoinput('winvideo',1);
% handles.vid2  = videoinput('winvideo',2);

%Managing handles timer
handles.timer= timer(...
    'ExecutionMode', 'fixedRate', ...       % Run timer repeatedly
    'Period', 0.1, ...                        % Initial period is 1 sec.
    'TimerFcn', {@Changedisplay,hObject,handles}); % Specify callback function
%start(handles.timer);

% Update handles structure
guidata(hObject, handles);
% UIWAIT makes GUI_Design_2015_04_22 wait for user response (see UIRESUME)
%uiwait(handles.figure1);
%--------------------------------------------------------------------------


% --- Outputs from this function are returned to the command line.
function varargout = GUI_Design_2015_04_22_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;
% -----------------------------------------------------------------------


%--------------------------------------------------------------------------
% Managing Edit Texbox Components
%--------------------------------------------------------------------------

%------------------------Input Joint Angle---------------------------------

function Joint_Angle_1_Callback(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
function Joint_Angle_1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Joint_Angle_2_Callback(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
function Joint_Angle_2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Joint_Angle_3_Callback(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
function Joint_Angle_3_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Joint_Angle_4_Callback(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
function Joint_Angle_4_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Joint_Angle_5_Callback(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
function Joint_Angle_5_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Joint_Angle_6_Callback(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
function Joint_Angle_6_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%-----------------Input End Effector Goal----------------------------------

function X_Input_Callback(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
function X_Input_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Y_Input_Callback(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
function Y_Input_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Z_Input_Callback(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
function Z_Input_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%-------------------Speed Setting Input------------------------------------

function editSpeed_Callback(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
function editSpeed_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%-------------------Command Output & Status Robot--------------------------

function CmdStatus_Callback(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
function CmdStatus_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function C_Coordinate_Callback(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
function C_Coordinate_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function T_Coordinate_Callback(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
function T_Coordinate_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function CurrentPosition_Callback(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
function CurrentPosition_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function CurrentJoint_Callback(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
function CurrentJoint_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function CurrentIO_Callback(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
function CurrentIO_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%--------------------------------------------------------------------------


%--------------------------------------------------------------------------
% Managing Axis
%--------------------------------------------------------------------------
function ConvCam_CreateFcn(hObject, eventdata, handles)
% Hint: place code in OpeningFc
% --- Executes during object creation, after setting all properties.

%--------------------------------------------------------------------------
% Manage Slider Objects
%--------------------------------------------------------------------------
% --- Executes on slider movement.
function Joint_1_Callback(hObject, eventdata, handles)
Position = get(handles.Joint_1,'Value');
pause(0.2);
IPosition = int64(Position);
SPosition = num2str(IPosition);

sender('1');
pause(.01);
data=sprintf('[%s,%s,%s,%s,%s,%s]',SPosition, handles.CJ2, handles.CJ3, ...
    handles.CJ4, handles.CJ5, handles.CJ6);
sender(data);
pause(.1);

JointStatus = sprintf('Move Joint 1 to %s degree' , SPosition);
set ( handles.CmdStatus, 'String' , JointStatus ) ;
set ( handles.Joint_Angle_1, 'String' , SPosition ) ;

% --- Executes during object creation, after setting all properties.
function Joint_1_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function Joint_2_Callback(hObject, eventdata, handles)
Position = get(handles.Joint_2,'Value');
IPosition = int64(Position);
SPosition = num2str(IPosition);
sender('1');
pause(.01);
data=sprintf('[%s,%s,%s,%s,%s,%s]',handles.CJ1, SPosition, handles.CJ3, ...
    handles.CJ4, handles.CJ5, handles.CJ6);
sender(data);
pause(.1);
JointStatus = sprintf('Move Joint 2 to %s degree' , SPosition);
set ( handles.CmdStatus, 'String' , JointStatus ) ;
set ( handles.Joint_Angle_1, 'String' , SPosition ) ;

% --- Executes during object creation, after setting all properties.
function Joint_2_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function Joint_3_Callback(hObject, eventdata, handles)
Position = get(handles.Joint_3,'Value');
IPosition = int64(Position);
SPosition = num2str(IPosition);
sender('1');
pause(.01);
data=sprintf('[%s,%s,%s,%s,%s,%s]',handles.CJ1, handles.CJ2, SPosition,...
    handles.CJ4, handles.CJ5, handles.CJ6);
sender(data);
pause(.1);
JointStatus = sprintf('Move Joint 3 to %s degree' , SPosition);
set ( handles.CmdStatus, 'String' , JointStatus ) ;
set ( handles.Joint_Angle_1, 'String' , SPosition );

% --- Executes during object creation, after setting all properties.
function Joint_3_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function Joint_4_Callback(hObject, eventdata, handles)
Position = get(handles.Joint_4,'Value');
IPosition = int64(Position);
SPosition = num2str(IPosition);
sender('1');
pause(.01);
data=sprintf('[%s,%s,%s,%s,%s,%s]',handles.CJ1, handles.CJ2,  ...
    handles.CJ3, SPosition, handles.CJ5, handles.CJ6);
sender(data);
pause(.1);
JointStatus = sprintf('Move Joint 4 to %s degree' , SPosition);
set ( handles.CmdStatus, 'String' , JointStatus ) ;
set ( handles.Joint_Angle_1, 'String' , SPosition ) ;

% --- Executes during object creation, after setting all properties.
function Joint_4_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function Joint_5_Callback(hObject, eventdata, handles)
Position = get(handles.Joint_5,'Value');
IPosition = int64(Position);
SPosition = num2str(IPosition);
sender('1');
pause(.01);
data=sprintf('[%s,%s,%s,%s,%s,%s]',handles.CJ1, handles.CJ2,  handles.CJ3...
    , handles.CJ4, SPosition, handles.CJ6);
sender(data);
pause(.1);
JointStatus = sprintf('Move Joint 5 to %s degree' , SPosition);
set ( handles.CmdStatus, 'String' , JointStatus ) ;
set ( handles.Joint_Angle_1, 'String' , SPosition ) ;

% --- Executes during object creation, after setting all properties.
function Joint_5_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function Joint_6_Callback(hObject, eventdata, handles)
Position = get(handles.Joint_6,'Value');
IPosition = int64(Position);
SPosition = num2str(IPosition);
sender('1');
pause(.01);
data=sprintf('[%s,%s,%s,%s,%s,%s]',handles.CJ1, handles.CJ2,  handles.CJ3...
    , handles.CJ4, handles.CJ5, SPosition);
sender(data);
pause(.1);
JointStatus = sprintf('Move Joint 6 to %s degree' , SPosition);
set ( handles.CmdStatus, 'String' , JointStatus );
set ( handles.Joint_Angle_1, 'String' , SPosition );

% --- Executes during object creation, after setting all properties.
function Joint_6_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
%--------------------------------------------------------------------------


%--------------------------------------------------------------------------
% Managing Button Object
%--------------------------------------------------------------------------

% ------------------------JOG Button---------------------------------------
function X_Plus_Button_Callback(hObject, eventdata, handles)
NewX = handles.PositionR(1)+10;
sender('0');
pause(0.01);
data=sprintf('[%d,%d,%d]',NewX, handles.PositionR(2),handles.PositionR(3));
sender(data);
set ( handles.CmdStatus, 'String' , 'Move End Efector Robot Linear Mode Into X+ Direction ' ) ;

function X_Min_Button_Callback(hObject, eventdata, handles)
NewX = handles.PositionR(1)-10;
sender('0');
pause(0.01);
data=sprintf('[%d,%d,%d]',NewX, handles.PositionR(2),handles.PositionR(3));
sender(data);
set ( handles.CmdStatus, 'String' , 'Move End Efector Robot Linear Mode Into X- Direction ' ) ;

function Y_Plus_Button_Callback(hObject, eventdata, handles)
NewY = handles.PositionR(2)+10;
sender('0');
pause(0.01);
data=sprintf('[%d,%d,%d]',handles.PositionR(1),NewY,handles.PositionR(3));
sender(data);
set (handles.CmdStatus, 'String' , 'Move End Efector Robot Linear Mode Into Y+ Direction ' ) ;

function Y_Min_Button_Callback(hObject, eventdata, handles)
NewY = handles.PositionR(2)-10;
sender('0');
pause(0.01);
data=sprintf('[%d,%d,%d]',handles.PositionR(1),NewY,handles.PositionR(3));
sender(data);
set ( handles.CmdStatus, 'String' , 'Move End Efector Robot Linear Mode Into Y- Direction ' ) ;

function Z_Plus_Button_Callback(hObject, eventdata, handles)
NewZ = handles.PositionR(3)+10;
sender('0');
pause(0.01);
data=sprintf('[%d,%d,%d]',handles.PositionR(1),handles.PositionR(2),NewZ);
sender(data);
set ( handles.CmdStatus, 'String' , 'Move End Efector Robot Linear Mode Into Z+ Direction ' ) ;

function Z_Min_Button_Callback(hObject, eventdata, handles)
NewZ = handles.PositionR(3)-10;
sender('0');
pause(0.01);
data=sprintf('[%d,%d,%d]',handles.PositionR(1),handles.PositionR(2),NewZ);
sender(data);
set ( handles.CmdStatus, 'String' , 'Move End Efector Robot Linear Mode Into Z- Direction ' ) ;

% ------------------GO by End Effector Goal Button-------------------------

function GoByEndEffector_Callback(hObject, eventdata, handles)
x= get(handles.X_Input,'String'); 
y =get(handles.Y_Input,'String'); 
z =get(handles.Z_Input,'String'); 
sender('0');
pause(0.01);
data=sprintf('[%s,%s,%s]',x,y,z);
sender(data);
set ( handles.CmdStatus, 'String' ,...
    ['Move End Efector Robot Linear to ' num2str(handles.position1)] );

function GOJButton_Callback(hObject, eventdata, handles)
x= get(handles.X_Input,'String');
y =get(handles.Y_Input,'String');
z =get(handles.Z_Input,'String'); 
sender('4');
pause(0.01);
data=sprintf('[%s,%s,%s]',x,y,z);
sender(data);

% -----------------------GO by Joint Goal Button---------------------------

function Joint_GO_Callback(hObject, eventdata, handles)
J1S = get(handles.Joint_Angle_1,'String');
J1 = sscanf(J1S,'%d');
J2S = get(handles.Joint_Angle_2,'String');
J2 = sscanf(J2S,'%d');
J3S = get(handles.Joint_Angle_3,'String');
J3 = sscanf(J3S,'%d');
J4S = get(handles.Joint_Angle_4,'String');
J4 = sscanf(J4S,'%d');
J5S = get(handles.Joint_Angle_5,'String');
J5 = sscanf(J5S,'%d');
J6S = get(handles.Joint_Angle_6,'String');
J6 = sscanf(J6S,'%d');
sender('1');
pause(.01);
data=sprintf('[%s,%s,%s,%s,%s,%s]',J1S, J2S, J3S, J4S, J5S, J6S);
sender(data);
JointData = sprintf('Move In Jont Mode Into J1 = %d ; J2 = %d ; J3 = %d ; J4 = %d ; J5 = %d ; J6 = %d' ...
    , J1,J2,J3,J4,J5,J6);
set ( handles.CmdStatus, 'String' , JointData );

%------------------------Setting Speed Button------------------------------
function SpeedButton_Callback(hObject, eventdata, handles)
handles.Speed= get(handles.editSpeed, 'string');
sender('3');
pause(0.01);
data=sprintf('[%s,%s,%s,%s,%s,0]'...
    ,handles.Vac,handles.Sol,handles.CRun,handles.CDir,handles.Speed);
sender(data);

%------------------------Output Control Button-----------------------------

function SendOutput_Callback(hObject, eventdata, handles)
switch get(get(handles.ConvEnable,'SelectedObject'),'Tag')
    case 'ConvEnableOn',  CE='ON';
        handles.CRun ='1';
    case 'ConvEnableOff', CE='OFF';
        handles.CRun='0';
end

switch get(get(handles.VacPump,'SelectedObject'),'Tag')
    case 'VacPumpOn',  VP='ONN';
        handles.Vac= '1';
    case 'VacPumpOff', VP='OFF';
        handles.Vac= '0';
end

switch get(get(handles.ConvDirection,'SelectedObject'),'Tag')
    case 'ConvDirectionFW',  CD='Forward';
        handles.CDir = '1';
    case 'ConvDirectionBW', CD='Backward';
        handles.CDir = '0';
end

switch get(get(handles.SolValve,'SelectedObject'),'Tag')
    case 'SolValveOn',  SV='ON';
        handles.Sol = '1';
    case 'SolValveOff', SV='OFF';
        handles.Sol = '0';
end
handles.IO = [cON,dir,vac,sol,handles.speed,0];
sender('3');
pause(0.01);
data=sprintf('[%s,%s,%s,%s,%s,0]'...
    ,handles.Vac,handles.Sol,handles.CRun,handles.CDir,handles.Speed);
sender(data);
CommandStatus = sprintf('Set Output Conveyor Enable = %d, Conveyor Direction = %str, Vacuum Pump = %str, Solenoid Valve = %str', CE, VP, CD, SV);
set ( handles.CmdStatus, 'String' , CommandStatus ) ;

% ------------------Upate Slider Into Current Robot State------------------

function UpdateJoint_Callback(hObject, eventdata, handles)
set(handles.Joint_1,'value',handles.JointR(1));
set(handles.Joint_2,'value',handles.JointR(2));
set(handles.Joint_3,'value',handles.JointR(3));
set(handles.Joint_4,'value',handles.JointR(4));
set(handles.Joint_5,'value',handles.JointR(5));
set(handles.Joint_6,'value',handles.JointR(6));


%-------------------Video & Image Acquisition Button-----------------------

function ShowIm_Callback(hObject, eventdata, handles)
handles.vid1 .FramesPerTrigger = 1;
handles.vid1 .ReturnedColorspace = 'rgb';
triggerconfig(handles.vid1 , 'manual');
vidRes = get(handles.vid1 , 'VideoResolution');
imWidth = vidRes(1);
imHeight = vidRes(2);
nBands = get(handles.vid1 , 'NumberOfBands');
axes(handles.ConvCam);
hImage = image(zeros(imHeight,imWidth, nBands), 'parent', handles.ConvCam);
preview(handles.vid1,hImage);

function StopIm_Callback(hObject, eventdata, handles)
handles.vid2 .FramesPerTrigger = 1;
handles.vid2 .ReturnedColorspace = 'rgb';
triggerconfig(handles.vid2 , 'manual');
vidRes = get(handles.vid2 , 'VideoResolution');
imWidth = vidRes(1);
imHeight = vidRes(2);
nBands = get(handles.vid2 , 'NumberOfBands');
axes(handles.TableCam);
hImage2 = image(zeros(imHeight, imWidth, nBands), 'parent', handles.TableCam);
preview(handles.vid2,hImage2);

% --- Executes on button press in ImCapt.
function ImCapt_Callback(hObject, eventdata, handles)
%imgConv=getsnapshot(handles.vid2);% 1.Get snap shot
%set(handles.axes3);
axes(handles.ConvCam);
%imshow(imgConv);
hold on;
%plotBoxConv(imgConv);
imshow(imread('converyor.jpg'));
hold off;
axes(handles.TableCam);
imshow(imread('empty.png'));
c = [418.950185 643.119926 -2.235069 177.000000 81.000000 4.000000 1.000000 1.000000 1.000000 ;...
    472.086716 525.038745 1.264079 177.000000 81.000000 1.000000 1.000000 1.000000 1.000000 ;...
    601.976015 520.610701 -1.285772 177.000000 81.000000 4.000000 1.000000 1.000000 1.000000 ;...
    349.577491 427.621771 -1.785119 177.000000 81.000000 4.000000 1.000000 1.000000 1.000000 ;...
    497.178967 389.245387 0.048653 177.000000 81.000000 1.000000 1.000000 1.000000 1.000000 ;...
    413.046125 291.828413 -2.995013 177.000000 81.000000 1.000000 1.000000 1.000000 1.000000 ;...
    703.821033 300.684502 2.992951 177.000000 81.000000 3.000000 1.000000 1.000000 1.000000 ;...
    742.197417 380.389299 -0.165615 177.000000 81.000000 2.000000 1.000000 1.000000 1.000000];
set(handles.ChocTable,'Data',c);

%--------------------------Click & GO Button-------------------------------

function GetC_Coordinate_Callback(hObject, eventdata, handles)
[X, Y]=ginput(1);
XR=900-Y;
YR=X;
XR=XR*1.5;
YR=YR*1.5;
XR=int32(XR);
YR=int32(YR);
texboxStatus = sprintf('X = %d  Y = %d', XR, YR);
set(handles.C_Coordinate,'String',texboxStatus);
% sender('0');
% pause(0.01);
% data=sprintf('[%d,%d,150]',XR, YR);
% sender(data);
set ( handles.CmdStatus, 'String' ,...
    ['Move End Efector Robot Linear to ' ] );

function Get_T_Coordinate_Callback(hObject, eventdata, handles)
[X, Y]=ginput(1);
XR=900-Y;
YR=X;
XR=XR*1.25;
YR=YR*1.25;
XR=int32(XR);
YR=int32(YR);
texboxStatus = sprintf('X = %d  Y = %d', XR, YR);
set(handles.T_Coordinate,'String',texboxStatus);
% sender('0');
% pause(0.01);
% data=sprintf('[%d,%d,150]',XR, YR);
% sender(data);
set ( handles.CmdStatus, 'String' ,...
    ['Move End Efector Robot Linear to ' ] );

% ------------------Activate Timer To Connect Robot Studio-----------------

function connectButton_Callback(hObject, eventdata, handles)
if handles.Connect == 0,
    start(handles.timer);
    %start(handles.video1);
    %start(handles.video2);
    handles.Connect = 1;
    set(handles.connectButton,'String', 'Disconnect');
else
    %stop(handles.timer);
    %stop(handles.video1);
    %stop(handles.video2);
    handles.Connect = 0;
    set(handles.connectButton,'String', 'Connect');
end

% ----------------------PAUSE & RESUME BUTTON------------------------------

function resumeButton_Callback(hObject, eventdata, handles)
sender('S2');
set(handles.resumeButton,'Enable', 'off');
set(handles.pauseButton,'Enable', 'on');
set ( handles.CmdStatus, 'String' , 'RESUME' ) ;

function pauseButton_Callback(hObject, eventdata, handles)
sender('S1');
set(handles.resumeButton,'Enable', 'on');
set(handles.pauseButton,'Enable', 'off');
set ( handles.CmdStatus, 'String' , 'PAUSE' ) ;
%--------------------------------------------------------------------------

% ----------------------Calibrate Position Button--------------------------
function calibrateButton_Callback(hObject, eventdata, handles)
sender('2');
set ( handles.CmdStatus, 'String' , 'Move to Calibrate Position' );

%--------------------------------------------------------------------------


%--------------------------------------------------------------------------
% Managing Keyboard Press & Release
%--------------------------------------------------------------------------
% ------------------------KEY PRESS FUNCTION-------------------------------
function figure1_WindowKeyPressFcn(hObject, eventdata, handles)
switch eventdata.Key
  case 'a'
    set ( handles.CmdStatus, 'String' , 'Move Joint 1 CW ' ) ;
  case 's'
    set ( handles.CmdStatus, 'String' , 'Move Joint 2 CW ' ) ;
  case 'd'
    set ( handles.CmdStatus, 'String' , 'Move Joint 3 CW ' ) ;
  case 'f'
    set ( handles.CmdStatus, 'String' , 'Move Joint 4 CW ' ) ;
  case 'g'
    set ( handles.CmdStatus, 'String' , 'Move Joint 5 CW ' ) ;
  case 'h'
    set ( handles.CmdStatus, 'String' , 'Move Joint 6 CW ' ) ;
    
  case 'uparrow' 
    set ( handles.CmdStatus, 'String' , 'Move End Effector to Y+ ' ) ;
  case 'downarrow'
    set ( handles.CmdStatus, 'String' , 'Move End Effector to Y- ' ) ;
  case 'leftarrow'
    set ( handles.CmdStatus, 'String' , 'Move End Effector to X- ' ) ;
  case 'rightarrow'
    set ( handles.CmdStatus, 'String' , 'Move End Effector to X+ ' ) ;
  case 'z'
    set ( handles.CmdStatus, 'String' , 'Move End Effector to Z+ ' ) ;
  case 'x'
    set ( handles.CmdStatus, 'String' , 'Move End Effector to Z- ' ) ;
  
  case 'q'
    set ( handles.CmdStatus, 'String' , 'Move Joint 1 CCW ' ) ;
  case 'w'
    set ( handles.CmdStatus, 'String' , 'Move Joint 2 CCW ' ) ;
  case 'e'
    set ( handles.CmdStatus, 'String' , 'Move Joint 3 CCW ' ) ;
  case 'r'
    set ( handles.CmdStatus, 'String' , 'Move Joint 4 CCW ' ) ;
  case 't'
    set ( handles.CmdStatus, 'String' , 'Move Joint 5 CCW ' ) ;
  case 'y'
    set ( handles.CmdStatus, 'String' , 'Move Joint 6 CCW ' ) ;
end

% ----------------------KEY RELEASE FUNCTION-------------------------------
function figure1_WindowKeyReleaseFcn(hObject, eventdata, handles)
switch eventdata.Key
  case 'a'
    set ( handles.CmdStatus, 'String' , 'Stop Joint 1' ) ;
  case 's'
    set ( handles.CmdStatus, 'String' , 'Stop Joint 2' ) ;
  case 'd'
    set ( handles.CmdStatus, 'String' , 'Stop Joint 3' ) ;
  case 'f'
    set ( handles.CmdStatus, 'String' , 'Stop Joint 4' ) ;
  case 'g'
    set ( handles.CmdStatus, 'String' , 'Stop Joint 5' ) ;
  case 'h'
    set ( handles.CmdStatus, 'String' , 'Stop Joint 6' ) ;
  case 'uparrow' 
    set ( handles.CmdStatus, 'String' , 'Stop End Effector to Y+ ' ) ;
  case 'downarrow'
    set ( handles.CmdStatus, 'String' , 'Stop End Effector to Y- ' ) ;
  case 'leftarrow'
    set ( handles.CmdStatus, 'String' , 'Stop End Effector to X- ' ) ;
  case 'rightarrow'
    set ( handles.CmdStatus, 'String' , 'Stop End Effector to X+ ' ) ;
  case 'z'
    set ( handles.CmdStatus, 'String' , 'Stop End Effector to Z+ ' ) ;
  case 'x'
    set ( handles.CmdStatus, 'String' , 'Stop End Effector to Z- ' ) ;
  case 'q'
    set ( handles.CmdStatus, 'String' , 'Stop Joint 1' ) ;
  case 'w'
    set ( handles.CmdStatus, 'String' , 'Stop Joint 2' ) ;
  case 'e'
    set ( handles.CmdStatus, 'String' , 'Stop Joint 3' ) ;
  case 'r'
    set ( handles.CmdStatus, 'String' , 'Stop Joint 4' ) ;
  case 't'
    set ( handles.CmdStatus, 'String' , 'Stop Joint 5' ) ;
  case 'y'
    set ( handles.CmdStatus, 'String' , 'Stop Joint 6' ) ;
end
%-------------------------------------------------------------------------

%------------------- Managing Table Object---------------------------------
function ChocTable_CreateFcn(hObject, eventdata, handles)


%------------------------TIMER FUNCTION------------------------------------
function Changedisplay(hObject,eventdata,hfigure,handles)
[handles.PositionR, handles.JointR, handles.IOR] = Take_Rob_Status();
data = sprintf('X = %d Y = %d Z = %d'...
    ,handles.PositionR(1),handles.PositionR(2),handles.PositionR(3));
set(handles.CurrentPosition,'String',data); 
handles.X = sprintf('%d',handles.PositionR(1));
handles.Y = sprintf('%d',handles.PositionR(2));
handles.Z = sprintf('%d',handles.PositionR(3));

data = sprintf('J1 = %d J2 = %d J3 = %d J4 = %d J5 = %d J6 = %d'...
    ,handles.JointR(1),handles.JointR(2),handles.JointR(3),handles.JointR(4)...
    ,handles.JointR(5),handles.JointR(6));
set(handles.CurrentJoint,'String',data);

handles.CJ1 = sprintf('%d',handles.JointR(1));
handles.CJ2 = sprintf('%d',handles.JointR(2));
handles.CJ3 = sprintf('%d',handles.JointR(3));
handles.CJ4 = sprintf('%d',handles.JointR(4));
handles.CJ5 = sprintf('%d',handles.JointR(5));
handles.CJ6 = sprintf('%d',handles.JointR(6));
data = sprintf('DI1 = %d DO1 = %d DO2 = %d DO3 = %d DO4 = %d'...
    ,handles.IOR(1),handles.IOR(2),handles.IOR(4),handles.IOR(5));
set(handles.CurrentIO,'String',data);
drawnow();


%--------------------------------------------------------------------------
% Managing Close GUI
%--------------------------------------------------------------------------
% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
delete(hObject);
%delete(handles.vid1);
%delete(handles.vid2);
%delete(handles.timer);
