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

%--------Innitialize All Handles Variable That Will be Used----------------
%VALUES
handles.moving      = 0;                % Indicate the status of the robot in moving or not
handles.position    = [ 0,0,0]; 
handles.joint       = [ 0,0,0,0,0,0];
handles.Speed ='10';
handles.pause=0;
handles.chocolates = [];
handles.box = [];

% Initial Input Output - Conveyor Run ; Conveyor Direction ; Solenoid Valve
% ; Vacuum Pump
handles.CRun        ='0';   % Conveyor On/Off Output Status                  
handles.CDir        ='0';   % Conveyor direction output status
handles.Sol         ='0';   % Solenoid valve on/off output status
handles.Vac         ='0';   % Vacuum pump on/off output status

handles.Connect     = 0;    % Status connection with robot studio 0 = Unconnected ; 1 = Connected

% Initial Value for Current Joint Status 
% Current Joint 1 ---> Current Joint 6
% Before GUI connected & syncronize with Robot Studio
handles.CJ1 ='0';       % Joint 1 current status 
handles.CJ2 ='0';       % Joint 2 current status
handles.CJ3 ='0';       % Joint 3 current status
handles.CJ4 ='0';       % Joint 4 current status
handles.CJ5 ='0';       % Joint 5 current status
handles.CJ6 ='0';       % Joint 6 current status

% Initial Value for Current End Effector status 
% Before GUI connected & syncronize with Robot Studio 
handles.CX   = '0';     % Current end effector position on X 
handles.CY   = '0';     % Current end effector position on Y 
handles.CZ   = '0';     % Current end effector position on Z 

% Managing proper ties of Axis handles for showing the video & image
% processing result
% axes3 for showing detected choclate
% axes4 for showing detected box
% ConvCam for showing conveyor camera
% TableCam for showing table camera                      
set(handles.axes3, 'Xlim', [-800,800], 'YLim', [0 900]); % Setting limit axes tobe respect to the image resolution
set(handles.axes3,'xtick',[],'ytick',[]);       % Supress the axes3 axis value 
set(handles.axes4,'xtick',[],'ytick',[]);       % Supress the axes4 axis value
set(handles.ConvCam,'xtick',[],'ytick',[]);     % Supress the ConvCam axis value
set(handles.TableCam,'xtick',[],'ytick',[]);    % Supress the TableCam axis value

% Just for showing logo(robot picture in axes5)
axes(handles.axes5);
imshow(imread('preview.jpg'));

%Managing Video handles
% handles.vid1  = videoinput('macvideo',1);
% handles.vid2  = videoinput('macvideo',2);
handles.vid1  = videoinput('winvideo',1);       % Input video 1 from table camera
handles.vid2  = videoinput('winvideo',2);       % Input video 2 from conveyor camera

%Managing handles timer
handles.timer= timer(...
    'ExecutionMode', 'fixedRate', ...               % Run timer repeatedly in fix rate
    'Period', 0.1, ...                              % Initial period is 0.1 sec.
    'TimerFcn', {@Changedisplay,hObject,handles});  % Specify callback function that executed when timer iterated

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

%-----------------Input fo GO by Joint Angle Goal--------------------------

% ---------Texbox Input For Joint Angle 1------------------
function Joint_Angle_1_Callback(hObject, eventdata, handles)
% Executes during object creation, after setting all properties.
function Joint_Angle_1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% ---------Texbox Input For Joint Angle 2------------------
function Joint_Angle_2_Callback(hObject, eventdata, handles)
% Executes during object creation, after setting all properties.
function Joint_Angle_2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% ---------Texbox Input For Joint Angle 3------------------
function Joint_Angle_3_Callback(hObject, eventdata, handles)
% Executes during object creation, after setting all properties.
function Joint_Angle_3_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% ---------Texbox Input For Joint Angle 4------------------
function Joint_Angle_4_Callback(hObject, eventdata, handles)
% Executes during object creation, after setting all properties.
function Joint_Angle_4_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% ---------Texbox Input For Joint Angle 5------------------
function Joint_Angle_5_Callback(hObject, eventdata, handles)
% Executes during object creation, after setting all properties.
function Joint_Angle_5_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% ---------Texbox Input For Joint Angle 6------------------
function Joint_Angle_6_Callback(hObject, eventdata, handles)
% Executes during object creation, after setting all properties.
function Joint_Angle_6_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%-----------------Input fo GO by End Effector Goal-------------------------

% ---------Texbox Input X Coordinate Goal-------------
function X_Input_Callback(hObject, eventdata, handles)
% Executes during object creation, after setting all properties.
function X_Input_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% ---------Texbox Input Y Coordinate Goal-------------
function Y_Input_Callback(hObject, eventdata, handles)
% Executes during object creation, after setting all properties.
function Y_Input_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% ---------Texbox Input Z Coordinate Goal-------------
function Z_Input_Callback(hObject, eventdata, handles)
% Executes during object creation, after setting all properties.
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

% Texbox for showing the command sending to the robot
function CmdStatus_Callback(hObject, eventdata, handles)
% Executes during object creation, after setting all properties.
function CmdStatus_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Texbox for showing coordinate in conveyor camera
% that will be sending to the robot on Click n GO operation
function C_Coordinate_Callback(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
function C_Coordinate_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Texbox for showing coordinate in table camera
% that will be sending to the robot on Click n GO operation
function T_Coordinate_Callback(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
function T_Coordinate_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Texbox for showing realtime current position of the robot 
function CurrentPosition_Callback(hObject, eventdata, handles)
% Executes during object creation, after setting all properties.
function CurrentPosition_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Texbox for showing realtime current joint angle of the robot 
function CurrentJoint_Callback(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
function CurrentJoint_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Texbox for showing realtime current I/O status of the robot
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

% --- Executes on slider Joint 1 movement.
function Joint_1_Callback(hObject, eventdata, handles)
Position = get(handles.Joint_1,'Value');        % Get value of slider 1 when its moved   
pause(0.2);
IPosition = int64(Position);                    % Convert it into integer to avoid fraxtion
SPosition = num2str(IPosition);                 % Convert it into string for sending to TCP
sender('1');                                    % call sender function to send '1' move joint mode
pause(.01);
data=sprintf('[%s,%s,%s,%s,%s,%s]'...           % set data for sending ( new joint 1 data 
    ,SPosition, handles.CJ2, handles.CJ3, ...   % & current data for other joints
    handles.CJ4, handles.CJ5, handles.CJ6);
sender(data);                                   % call sender function to send data angle joint goal
pause(.1);
JointStatus = sprintf('Move Joint 1 to %s degree' , SPosition); % Set  command status
set ( handles.CmdStatus, 'String' , JointStatus ) ;             % Send command status into command texbox

% --- Executes during object creation, after setting all properties.
function Joint_1_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider Joint 2 movement.
function Joint_2_Callback(hObject, eventdata, handles)
Position = get(handles.Joint_2,'Value');        % Get value of slider 2 when its moved
IPosition = int64(Position);                    % Convert it into integer to avoid fraxtion
SPosition = num2str(IPosition);                 % Convert it into string for sending to TCP
sender('1');                                    % call sender function to send '1' move joint mode
pause(.01);
data=sprintf('[%s,%s,%s,%s,%s,%s]'...           % set data for sending ( new joint 2 data
    ,handles.CJ1, SPosition, handles.CJ3, ...   % & current data for other joints
    handles.CJ4, handles.CJ5, handles.CJ6);
sender(data);                                   % call sender function to send data angle joint goal
pause(.1);
JointStatus = sprintf('Move Joint 2 to %s degree' , SPosition); % Set  command status
set ( handles.CmdStatus, 'String' , JointStatus ) ;             % Send command status into command texbox

% --- Executes during object creation, after setting all properties.
function Joint_2_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider Joint 3 movement
function Joint_3_Callback(hObject, eventdata, handles)
Position = get(handles.Joint_3,'Value');        % Get value of slider 3 when its moved
IPosition = int64(Position);                    % Convert it into integer to avoid fraxtion
SPosition = num2str(IPosition);                 % Convert it into string for sending to TCP
sender('1');                                    % call sender function to send '1' move joint mode
pause(.01);
data=sprintf('[%s,%s,%s,%s,%s,%s]'...           % set data for sending ( new joint 3 data
    ,handles.CJ1, handles.CJ2, SPosition,...    % & current data for other joints
    handles.CJ4, handles.CJ5, handles.CJ6);
sender(data);                                   % call sender function to send data angle joint goal
pause(.1);
JointStatus = sprintf('Move Joint 3 to %s degree' , SPosition);  % Set  command status
set ( handles.CmdStatus, 'String' , JointStatus ) ;              % Send command status into command texbox

% --- Executes during object creation, after setting all properties.
function Joint_3_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider Joint 4 movement
function Joint_4_Callback(hObject, eventdata, handles)
Position = get(handles.Joint_4,'Value');        % Get value of slider 4 when its moved
IPosition = int64(Position);                    % Convert it into integer to avoid fraxtion
SPosition = num2str(IPosition);                 % Convert it into string for sending to TCP
sender('1');                                    % call sender function to send '1' move joint mode
pause(.01);
data=sprintf('[%s,%s,%s,%s,%s,%s]'...           % set data for sending ( new joint 4 data
    ,handles.CJ1, handles.CJ2, handles.CJ3,...  % & current data for other joints
    SPosition, handles.CJ5, handles.CJ6);
sender(data);                                   % call sender function to send data angle joint goal
pause(.1);
JointStatus = sprintf('Move Joint 4 to %s degree' , SPosition); % Set  command status
set ( handles.CmdStatus, 'String' , JointStatus ) ;             % Send command status into command texbox

% --- Executes during object creation, after setting all properties.
function Joint_4_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider Joint 5 movement
function Joint_5_Callback(hObject, eventdata, handles)
Position = get(handles.Joint_5,'Value');        % Get value of slider 5 when its moved
IPosition = int64(Position);                    % Convert it into integer to avoid fraxtion
SPosition = num2str(IPosition);                 % Convert it into string for sending to TCP
sender('1');                                    % call sender function to send '1' move joint mode
pause(.01);
data=sprintf('[%s,%s,%s,%s,%s,%s]'...           % set data for sending ( new joint 5 data
    ,handles.CJ1, handles.CJ2,  handles.CJ3...  % & current data for other joints
    , handles.CJ4, SPosition, handles.CJ6);
sender(data);                                   % call sender function to send data angle joint goal
pause(.1);
JointStatus = sprintf('Move Joint 5 to %s degree' , SPosition); % Set  command status
set ( handles.CmdStatus, 'String' , JointStatus ) ;             % Send command status into command texbox

% --- Executes during object creation, after setting all properties.
function Joint_5_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function Joint_6_Callback(hObject, eventdata, handles)
Position = get(handles.Joint_6,'Value');        % Get value of slider 6 when its moved
IPosition = int64(Position);                    % Convert it into integer to avoid fraxtion
SPosition = num2str(IPosition);                 % Convert it into string for sending to TCP
sender('1');                                    % call sender function to send '1' move joint mode
pause(.01);
data=sprintf('[%s,%s,%s,%s,%s,%s]'...           % set data for sending ( new joint 6 data
    ,handles.CJ1, handles.CJ2,  handles.CJ3...  % & current data for other joints
    , handles.CJ4, handles.CJ5, SPosition);
sender(data);                                   % call sender function to send data angle joint goal
pause(.1);
JointStatus = sprintf('Move Joint 6 to %s degree' , SPosition);  % Set  command status
set ( handles.CmdStatus, 'String' , JointStatus );               % Send command status into command texbox

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
NewX = handles.PositionR(1)+10;                         % Increment the value of X
sender('0');                                            % Send '0' as mode linear
pause(0.01);
data=sprintf('[%d,%d,%d]'...                            % Set new data to be sended
    ,NewX, handles.PositionR(2),handles.PositionR(3));
sender(data);                                           % Send the new target of linear mode
set ( handles.CmdStatus, ...                            % Show in command status
    'String' , 'Move End Efector Robot Linear Mode Into X+ Direction ' ) ;

function X_Min_Button_Callback(hObject, eventdata, handles)
NewX = handles.PositionR(1)-10;                         % Decrement the value of X
sender('0');                                            % Send '0' as mode linear
pause(0.01);
data=sprintf('[%d,%d,%d]'...                            % Set new data to be sended
    ,NewX, handles.PositionR(2),handles.PositionR(3));
sender(data);                                           % Send the new target of linear mode
set ( handles.CmdStatus, ...                            % Show in command status
    'String' , 'Move End Efector Robot Linear Mode Into X- Direction ' ) ;

function Y_Plus_Button_Callback(hObject, eventdata, handles)
NewY = handles.PositionR(2)+10;                         % Increment the value of Y
sender('0');                                            % Send '0' as mode linear
pause(0.01);
data=sprintf('[%d,%d,%d]'...                            % Set new data to be sended
    ,handles.PositionR(1),NewY,handles.PositionR(3));
sender(data);                                           % Send the new target of linear mode
set (handles.CmdStatus,...                              % Show in command status
    'String' , 'Move End Efector Robot Linear Mode Into Y+ Direction ' ) ;

function Y_Min_Button_Callback(hObject, eventdata, handles)
NewY = handles.PositionR(2)-10;                         % Decrement the value of Y
sender('0');                                            % Send '0' as mode linear
pause(0.01);
data=sprintf('[%d,%d,%d]'...                            % Set new data to be sended
    ,handles.PositionR(1),NewY,handles.PositionR(3));
sender(data);                                           % Send the new target of linear mode
set ( handles.CmdStatus, ...                            % Show in command status
    'String' , 'Move End Efector Robot Linear Mode Into Y- Direction ' ) ;

function Z_Plus_Button_Callback(hObject, eventdata, handles)
NewZ = handles.PositionR(3)+10;                         % Increment the value of Z
sender('0');                                            % Send '0' as mode linear
pause(0.01);
data=sprintf('[%d,%d,%d]'...                            % Set new data to be sended
    ,handles.PositionR(1),handles.PositionR(2),NewZ);
sender(data);                                           % Send the new target of linear mode
set ( handles.CmdStatus, ...                            % Show in command status
    'String' , 'Move End Efector Robot Linear Mode Into Z+ Direction ' ) ;

function Z_Min_Button_Callback(hObject, eventdata, handles)
NewZ = handles.PositionR(3)-10;                         % Decrement the value of Y
sender('0');                                            % Send '0' as mode linear
pause(0.01);
data=sprintf('[%d,%d,%d]'...                            % Set new data to be sended
    ,handles.PositionR(1),handles.PositionR(2),NewZ);
sender(data);                                           % Send the new target of linear mode
set ( handles.CmdStatus,...                             % Show in command status
    'String' , 'Move End Efector Robot Linear Mode Into Z- Direction ' ) ;

% ------------------GO by End Effector Goal Button-------------------------

function GoByEndEffector_Callback(hObject, eventdata, handles)
x= get(handles.X_Input,'String');                       % Get X value from textbox
y =get(handles.Y_Input,'String');                       % Get Y value from textbox
z =get(handles.Z_Input,'String');                       % Get Z value from textbox
sender('0');                                            % Send '0' as mode linear
pause(0.01);
data=sprintf('[%s,%s,%s]',x,y,z);                       % Set new data to be sended
sender(data);                                           % Send the new target of linear mode
set ( handles.CmdStatus, 'String' ,...                  % Show in command status
    ['Move End Efector Robot Linear to ' num2str(handles.position1)] );

function GOJButton_Callback(hObject, eventdata, handles)
x= get(handles.X_Input,'String');       % Get X value from textbox
y =get(handles.Y_Input,'String');       % Get Y value from textbox
z =get(handles.Z_Input,'String');       % Get Z value from textbox
sender('4');                            % Send '4' as mode moveJ
pause(0.01);
data=sprintf('[%s,%s,%s]',x,y,z);       % Set new data to be sended
sender(data);                           % Send the new target of join mode

% -----------------------GO by Joint Goal Button---------------------------

function Joint_GO_Callback(hObject, eventdata, handles)
J1S = get(handles.Joint_Angle_1,'String');  % Get data from texbox as input joint 1 angle goal
J1 = sscanf(J1S,'%d');
J2S = get(handles.Joint_Angle_2,'String');  % Get data from texbox as input joint 2 angle goal
J2 = sscanf(J2S,'%d');
J3S = get(handles.Joint_Angle_3,'String');  % Get data from texbox as input joint 3 angle goal
J3 = sscanf(J3S,'%d');
J4S = get(handles.Joint_Angle_4,'String');  % Get data from texbox as input joint 4 angle goal
J4 = sscanf(J4S,'%d');
J5S = get(handles.Joint_Angle_5,'String');  % Get data from texbox as input joint 5 angle goal
J5 = sscanf(J5S,'%d');
J6S = get(handles.Joint_Angle_6,'String');  % Get data from texbox as input joint 6 angle goal
J6 = sscanf(J6S,'%d');
sender('1');                    % Call sender function to send character '1' as mode joint move
pause(.01);
data=sprintf('[%s,%s,%s,%s,%s,%s]',J1S, J2S, J3S, J4S, J5S, J6S); % set string as data goal joint angle to be sended
sender(data);                   % Call sender function to send caracter (data) as goal for move every joint robot
JointData = sprintf('Move In Jont Mode Into J1 = %d ; J2 = %d ; J3 = %d ; J4 = %d ; J5 = %d ; J6 = %d' ...
    , J1,J2,J3,J4,J5,J6);
set ( handles.CmdStatus, 'String' , JointData );    % Show in command status

%------------------------Setting Speed Button------------------------------
function SpeedButton_Callback(hObject, eventdata, handles)
handles.Speed= get(handles.editSpeed, 'string');    % Get speed data input from the textbox
sender('3');                                        % Call sender function to send '3' as speed change mode
pause(0.01);
data=sprintf('[%s,%s,%s,%s,%s,0]'...                % Set data tobe sended as string
    ,handles.Vac,handles.Sol...
    ,handles.CRun,handles.CDir,handles.Speed);
sender(data);                                       % Call sender function to send speed data

%------------------------Output Control Button-----------------------------

function SendOutput_Callback(hObject, eventdata, handles)

% --------Conveyor Start / Stop--------------------------
switch get(get(handles.ConvEnable,'SelectedObject'),'Tag')
    case 'ConvEnableOn',  CE='ON';
        handles.CRun ='1';
    case 'ConvEnableOff', CE='OFF';
        handles.CRun='0';
end

% --------Vacuum Pump ON / OFF--------------------------
switch get(get(handles.VacPump,'SelectedObject'),'Tag')
    case 'VacPumpOn',  VP='ONN';
        handles.Vac= '1';
    case 'VacPumpOff', VP='OFF';
        handles.Vac= '0';
end

% --------Conveyor Direction CW / CCW ----------------------
switch get(get(handles.ConvDirection,'SelectedObject'),'Tag')
    case 'ConvDirectionFW',  CD='Forward';
        handles.CDir = '1';
    case 'ConvDirectionBW', CD='Backward';
        handles.CDir = '0';
end

% --------Solenoid Valve ON / OFF----------------------
switch get(get(handles.SolValve,'SelectedObject'),'Tag')
    case 'SolValveOn',  SV='ON';
        handles.Sol = '1';
    case 'SolValveOff', SV='OFF';
        handles.Sol = '0';
end

sender('3');                                        % Call sender function to send '3' as I/O mode
pause(0.01);
data=sprintf('[%s,%s,%s,%s,%s,0]'...                % Set the data to be sended
    ,handles.Vac,handles.Sol,...
    handles.CRun,handles.CDir,handles.Speed);
sender(data);                                       % Call sender data to send data of I/O
CommandStatus = sprintf('Set Output Conveyor Enable = %d, Conveyor Direction = %str, Vacuum Pump = %str, Solenoid Valve = %str'...
    , CE, VP, CD, SV);
set ( handles.CmdStatus, 'String' , CommandStatus ) ;   % Show the command into command status

% ------------------Upate Slider Into Current Robot State------------------

function UpdateJoint_Callback(hObject, eventdata, handles)
% Set & update value of slider 1 - slider 6 equivalent to the current joint angle
set(handles.Joint_1,'value',handles.JointR(1));         % Joint 1
set(handles.Joint_2,'value',handles.JointR(2));         % Joint 2
set(handles.Joint_3,'value',handles.JointR(3));         % Joint 3
set(handles.Joint_4,'value',handles.JointR(4));         % Joint 4
set(handles.Joint_5,'value',handles.JointR(5));         % Joint 5
set(handles.Joint_6,'value',handles.JointR(6));         % Joint 6


%-------------------Video & Image Acquisition Button-----------------------

function ShowIm_Callback(hObject, eventdata, handles)
handles.vid1 .FramesPerTrigger = 1;                 % set number frame per trigger
handles.vid1 .ReturnedColorspace = 'rgb';           % set colorspace of the video image as rgb
triggerconfig(handles.vid1 , 'manual');             % Set triger video as manual so video will on until user stop it
vidRes = get(handles.vid1 , 'VideoResolution');     % Get video resolution
imWidth = vidRes(1); imHeight = vidRes(2);          % Get size of the video image
nBands = get(handles.vid1 , 'NumberOfBands');       
axes(handles.ConvCam);                              % set axes ConvCam for showing video 1
hImage = image(zeros(imHeight,imWidth, nBands), ... % set image frame as a the size of video image as a base for showing 
    'parent', handles.ConvCam);                     % video image
preview(handles.vid1,hImage);                       % show video image 1 on hImage frame

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
preview(handles.vid2,hImage2);                      % show video image 2 on hImage2 frame

% --- Executes on button press in ImCapt.
function ImCapt_Callback(hObject, eventdata, handles)

% Capture table camera, process it, detect choclate, & show it in axes 3
imgTable=getsnapshot(handles.vid1);     % capture image from video 1 (Table camera)
c=detect_chocolates(imTable);           % call function detect_chocolates to process the image to detect chocolate
set(handles.axes3);                     % set axes 3 for showing detected chocolate
handle.c =c;                            % data chocolate
set(handles.ChocTable,'Data',handle.c); % show data chocolate on the table 

% Capture conveyor camera, process it, detect the box & show it in axes 4
imgConv=getsnapshot(handles.vid2);      % capture image from video 2 (conveyor camera)
handles.box = plotBoxConv(imgConv);                   % call function plotBoxConv to detect box
set(handles.axes4);                     % set axes34 to show detected box

imgTble = getsnapshot(handles.vid1);      % ----------------------
handles.chocolates = findChoc(imgTble);   % HERE THE CHOC DETECTION
set(handles.axes3);                       % --------------------
    
guidata(hObject, handles);

%--------------------------Click & GO Button-------------------------------

% Executed when Click & GO button on Table camera pressed 
function GetC_Coordinate_Callback(hObject, eventdata, handles)
[X, Y]=ginput(1);                                   % Get input coordinate from the table camera frame
XR=900-Y; YR=X; XR=XR*1.5; YR=YR*1.5;               % Convert & adjust the measurement from pixle to mm
XR=int32(XR); YR=int32(YR);                         % Convert X & Y value into integer
texboxStatus = sprintf('X = %d  Y = %d', XR, YR);   % Set data to be showed
set(handles.C_Coordinate,'String',texboxStatus);    % Show value into textbox
sender('0');                                        % Call sender function to send '0' as linear mode
pause(0.01);
data=sprintf('[%d,%d,150]',XR, YR);                 % Set data to be sended 
sender(data);                                       % Call sender function to send data
set ( handles.CmdStatus, 'String' ,...              % Show command in the command status
    ['Move End Efector Robot Linear to ' ] );

% Executed when Click & GO button on Table camera pressed 
function Get_T_Coordinate_Callback(hObject, eventdata, handles)
[X, Y]=ginput(1);                                   % Get input coordinate from the table camera frame                            %
XR=900-Y; YR=X; XR=XR*1.25; YR=YR*1.25;             % Convert & adjust the measurement from pixle to mm
XR=int32(XR);                                       % Convert X value into integer
YR=int32(YR);                                       % Convert Y value into integer
texboxStatus = sprintf('X = %d  Y = %d', XR, YR);   % Set data to be showed 
set(handles.T_Coordinate,'String',texboxStatus);    % Show value into textbox
sender('0');                                        % Call sender function to send '0' as linear mode
pause(0.01);
data=sprintf('[%d,%d,150]',XR, YR);                 % Set data to be sended                
sender(data);                                       % Call sender function to send data
set ( handles.CmdStatus, 'String' ,...              % Show command in the command status
    ['Move End Efector Robot Linear to ' ] );

% ------------------Activate Timer To Connect Robot Studio-----------------

function connectButton_Callback(hObject, eventdata, handles)
if handles.Connect == 0,        % When it hasn't connected yet
    start(handles.timer);       % Start timer 1 to connect with robot studio periodically
    start(handles.vid1);        % start video 1 to connect with the table camera
    start(handles.vid2);        % start video 2 to connect with the conveyor camera
    handles.Connect = 1;        % make the connection status = 1 ---> Connected
    set(handles.connectButton,'String', 'Disconnect');  % Turn connect button into disconnect button
else                            % When it already connected
    stop(handles.timer);        % Stop timer to stop connection wit the robot
    stop(handles.vid1);         % stop video 2 to disconnect from table camera
    stop(handles.vid2);         % stop video 2 to disconnect from conveyor camera
    handles.Connect = 0;        % make the connection status = 0 ---> unconnected
    set(handles.connectButton,'String', 'Connect'); % Turn the button into connect button
end

% ----------------------PAUSE & RESUME BUTTON------------------------------

% Executed when the resume button pressed
function resumeButton_Callback(hObject, eventdata, handles)
sender('S2');                                   % Call function sender to send character 'S2' into robot studio
set(handles.resumeButton,'Enable', 'off');      % Make the resume button disable
set(handles.pauseButton,'Enable', 'on');        % Make the pause button enable
set ( handles.CmdStatus, 'String' , 'RESUME' ); % Show in the command status texbox RESUME

% Executed when the pause button pressed
function pauseButton_Callback(hObject, eventdata, handles)
sender('S1');                                   % Call function sender to send character 'S1' into robot studio
set(handles.resumeButton,'Enable', 'on');       % Make the resume button enable
set(handles.pauseButton,'Enable', 'off');       % Make the pause button disable while the robot is paused
set ( handles.CmdStatus, 'String' , 'PAUSE' ) ; % Show in the command status texbox PAUSE
%--------------------------------------------------------------------------

% ----------------------Calibrate Position Button--------------------------

% Executed when the calibrate pos button pressed
function calibrateButton_Callback(hObject, eventdata, handles)
sender('2');                                                        % Call function sender to send charachter '2' into robot studio
set ( handles.CmdStatus, 'String' , 'Move to Calibrate Position' ); % Show in the command status 

%--------------------------------------------------------------------------


%--------------------------------------------------------------------------
% Managing Keyboard Press & Release
%--------------------------------------------------------------------------
% ------------------------KEY PRESS FUNCTION-------------------------------
% These functions are executed when one of these caracter on keybord are
% pressed
% -------------------------------------------------------------------------
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
% These functions are executed when one of these caracter on keybord are
% released
% -------------------------------------------------------------------------
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
% Creating table object to show the list of detected chocolate
function ChocTable_CreateFcn(hObject, eventdata, handles)


%------------------------TIMER FUNCTION------------------------------------
% This function will be executed every time timer object iterated
%--------------------------------------------------------------------------

function Changedisplay(hObject,eventdata,hfigure,handles)

[handles.PositionR, handles.JointR, handles.IOR] = Take_Rob_Status(); % Read output from function Take_Rob_Status

data = sprintf('X = %d Y = %d Z = %d'...
    ,handles.PositionR(1),handles.PositionR(2),handles.PositionR(3));
set(handles.CurrentPosition,'String',data);     % Show current end effector position on the texbox

handles.CX = sprintf('%d',handles.PositionR(1)); % Store current X position on the string
handles.CY = sprintf('%d',handles.PositionR(2)); % Store current Y position on the string
handles.CZ = sprintf('%d',handles.PositionR(3)); % Store current Z position on the string

data = sprintf('J1 = %d J2 = %d J3 = %d J4 = %d J5 = %d J6 = %d'...
    ,handles.JointR(1),handles.JointR(2),handles.JointR(3),handles.JointR(4)...
    ,handles.JointR(5),handles.JointR(6));
set(handles.CurrentJoint,'String',data);        % Show current joint 1-6 angle on the texbox

handles.CJ1 = sprintf('%d',handles.JointR(1));  % Store current Joint 1 angle on the string 
handles.CJ2 = sprintf('%d',handles.JointR(2));  % Store current Joint 2 angle on the string
handles.CJ3 = sprintf('%d',handles.JointR(3));  % Store current Joint 3 angle on the string
handles.CJ4 = sprintf('%d',handles.JointR(4));  % Store current Joint 4 angle on the string
handles.CJ5 = sprintf('%d',handles.JointR(5));  % Store current Joint 5 angle on the string
handles.CJ6 = sprintf('%d',handles.JointR(6));  % Store current Joint 6 angle on the string

data = sprintf('DI1 = %d DO1 = %d DO2 = %d DO3 = %d DO4 = %d'...
    ,handles.IOR(1),handles.IOR(2),handles.IOR(4),handles.IOR(5));
set(handles.CurrentIO,'String',data);           % Show current input - output status on the texbox

drawnow();  % Push matlab to show the result before executing another function


%--------------------------------------------------------------------------
% Managing Close GUI
%--------------------------------------------------------------------------
% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
delete(hObject);
delete(handles.vid1);   % Delete object input vodeo 1 before closing the GUI
delete(handles.vid2);   % Delete object input vodeo 2 before closing the GUI
delete(handles.timer);  % Delete object timer before closing the GUI
