function varargout = GUI_Design_2015_04_8(varargin)

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_Design_2015_04_8_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_Design_2015_04_8_OutputFcn, ...
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


% --- Executes just before GUI_Design_2015_04_8 is made visible.
function GUI_Design_2015_04_8_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_Design_2015_04_8 (see VARARGIN)

% Choose default command line output for GUI_Design_2015_04_8

% Set All Handles Variable
% handles.ConveyorEnable = 1;
%handles.output = hObject;
% handles.socketR = tcpip('127.0.0.1',1026);
% set(handles.socketR, 'ReadAsyncMode', 'continuous'); 
% fopen(handles.socketR);
%setSocket = tcpip(ip, portR);
%constant
%ip   = '127.0.0.1';%diff
%port = 1025; %write port
%portR = 1026;

%handles.socket = tcpip(ip, port);

 %set(setSocket, 'ReadyAsyncMode', 'continuous');
% set(socketR, 'ReadyAsyncMode', 'continuous');
%fopen(setSocket);
handles.output = hObject;

%VALUES
handles.moving = 0;
handles.position = [ 0,0,0]; 
handles.joint    = [ 0,0,0,0,0,0];
handles.CRun ='0';   
handles.CDir ='0';
handles.Sol ='0';
handles.Vac ='0';
handles.Speed ='10';
handles.pause=0;

%handles.speed    = handles.IO(5);
handles.s        = [0,0];
handles.X = '0'; 
handles.Y = '0';
handles.Z = '0';
handles.CJ1 ='0'; 
handles.CJ2 ='0';
handles.CJ3 ='0';
handles.CJ4 ='0';
handles.CJ5 ='0';
handles.CJ6 ='0';
handles.IOR       = [0,0,0,0,0]; %the last value must be 0

set(handles.axes3,'Visible','On');
set(handles.axes3, 'Xlim', [-800,800], 'YLim', [0 900]);
set(handles.axes3,'xtick',[],'ytick',[]);
set(handles.ConvCam,'xtick',[],'ytick',[]);
set(handles.TableCam,'xtick',[],'ytick',[])
set(handles.axes4,'Visible','On');
set(handles.axes4, 'Xlim', [-800,800], 'YLim', [0 900]);
set(handles.axes4,'xtick',[],'ytick',[]);

%---------------------------------------------------
% set(findall(handles.ConvEnable, '-property', 'enable'), 'enable', 'off');
% set(findall(handles.ConvDirection, '-property', 'enable'), 'enable', 'off');
% set(findall(handles.VacPump, '-property', 'enable'), 'enable', 'off');
% set(findall(handles.SolValve, '-property', 'enable'), 'enable', 'off');
% set(findall(handles.JointPositionInput, '-property', 'enable'), 'enable', 'off');
% set(findall(handles.EndEffectorGoal, '-property', 'enable'), 'enable', 'off');

%handles.vid1  = webcam('FaceTime HD Camera');
%handles.vid2  = webcam('Logitech Camera');

handles.vid1  = videoinput('winvideo',1);
% handles.vid1.Resolution = '1600x900';
handles.vid2  = videoinput('winvideo',2);

handles.timer= timer(...
    'ExecutionMode', 'fixedRate', ...       % Run timer repeatedly
    'Period', 0.1, ...                        % Initial period is 1 sec.
    'TimerFcn', {@Changedisplay,hObject,handles}); % Specify callback function

%start(handles.timer);
% Update handles structure
guidata(hObject, handles);
% UIWAIT makes GUI_Design_2015_04_8 wait for user response (see UIRESUME)
%uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_Design_2015_04_8_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

% --- Executes on button press in checkbox5.
function checkbox5_Callback(hObject, eventdata, handles)
% Hint: get(hObject,'Value') returns toggle state of checkbox5

% --- Executes on button press in checkbox6.
function checkbox6_Callback(hObject, eventdata, handles)
% Hint: get(hObject,'Value') returns toggle state of checkbox6

% --- Executes on button press in checkbox7.
function checkbox7_Callback(hObject, eventdata, handles)
% Hint: get(hObject,'Value') returns toggle state of checkbox7


% --- Executes on button press in checkbox8.
function checkbox8_Callback(hObject, eventdata, handles)
% Hint: get(hObject,'Value') returns toggle state of checkbox8

% --- Executes on button press in checkbox9.
function checkbox9_Callback(hObject, eventdata, handles)
% Hint: get(hObject,'Value') returns toggle state of checkbox9

% --- Executes on button press in checkbox10.
function checkbox10_Callback(hObject, eventdata, handles)
% Hint: get(hObject,'Value') returns toggle state of checkbox10


% --- Executes on button press in checkbox11.
function checkbox11_Callback(hObject, eventdata, handles)
% Hint: get(hObject,'Value') returns toggle state of checkbox11

% --- Executes on button press in checkbox12.
function checkbox12_Callback(hObject, eventdata, handles)
% Hint: get(hObject,'Value') returns toggle state of checkbox12

% --- Executes on button press in checkbox13.
function checkbox13_Callback(hObject, eventdata, handles)
% Hint: get(hObject,'Value') returns toggle state of checkbox13

function edit13_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double

% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function slider9_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% --- Executes during object creation, after setting all properties.
function slider9_CreateFcn(hObject, eventdata, handles)
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function slider10_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% --- Executes during object creation, after setting all properties.
function slider10_CreateFcn(hObject, eventdata, handles)
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function edit7_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double

% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit8_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double

% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit9_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double

% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit10_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double

% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit11_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double

% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit12_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function Joint_Angle_1_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of Joint_Angle_1 as text
%        str2double(get(hObject,'String')) returns contents of Joint_Angle_1 as a double

% --- Executes during object creation, after setting all properties.
function Joint_Angle_1_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Input_Joint_3_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of Input_Joint_3 as text
%        str2double(get(hObject,'String')) returns contents of Input_Joint_3 as a double


% --- Executes during object creation, after setting all properties.
function Input_Joint_3_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Joint_Angle_6_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of Joint_Angle_6 as text
%        str2double(get(hObject,'String')) returns contents of Joint_Angle_6 as a double

% --- Executes during object creation, after setting all properties.
function Joint_Angle_6_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Joint_Angle_2_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of Joint_Angle_2 as text
%        str2double(get(hObject,'String')) returns contents of Joint_Angle_2 as a double

% --- Executes during object creation, after setting all properties.
function Joint_Angle_2_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Joint_Angle_4_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of Joint_Angle_4 as text
%        str2double(get(hObject,'String')) returns contents of Joint_Angle_4 as a double

% --- Executes during object creation, after setting all properties.
function Joint_Angle_4_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Joint_Angle_5_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of Joint_Angle_5 as text
%        str2double(get(hObject,'String')) returns contents of Joint_Angle_5 as a double

% --- Executes during object creation, after setting all properties.
function Joint_Angle_5_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% Hint: get(hObject,'Value') returns toggle state of radiobutton1

% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% Hint: get(hObject,'Value') returns toggle state of radiobutton2

% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% Hint: get(hObject,'Value') returns toggle state of radiobutton3

% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% Hint: get(hObject,'Value') returns toggle state of radiobutton4

% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject, eventdata, handles)
% Hint: get(hObject,'Value') returns toggle state of radiobutton5

% --- Executes on button press in radiobutton6.
function radiobutton6_Callback(hObject, eventdata, handles)
% Hint: get(hObject,'Value') returns toggle state of radiobutton6

% --- Executes on button press in radiobutton7.
function radiobutton7_Callback(hObject, eventdata, handles)
% Hint: get(hObject,'Value') returns toggle state of radiobutton7

% --- Executes on button press in radiobutton8.
function radiobutton8_Callback(hObject, eventdata, handles)
% Hint: get(hObject,'Value') returns toggle state of radiobutton8

% --- Executes during object creation, after setting all properties.
function ConvCam_CreateFcn(hObject, eventdata, handles)
% Hint: place code in OpeningFcn to populate ConvCam

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes during object creation, after setting all properties.
function uipanel2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes on slider movement.
function Joint_1_Callback(hObject, eventdata, handles)
Position = get(handles.Joint_1,'Value');
pause(0.2);
IPosition = int64(Position);
SPosition = num2str(IPosition);

sender('1');
pause(.01);
data=sprintf('[%s,%s,%s,%s,%s,%s]',SPosition, handles.CJ2, handles.CJ3, handles.CJ4...
    , handles.CJ5, handles.CJ6);
sender(data);
pause(.1);

JointStatus = sprintf('Move Joint 1 to %s degree' , SPosition);
set ( handles.CmdStatus, 'String' , JointStatus ) ;
set ( handles.Joint_Angle_1, 'String' , SPosition ) ;
%CALL FUNCTION
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% --- Executes during object creation, after setting all properties.
function Joint_1_CreateFcn(hObject, eventdata, handles)
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function Joint_2_Callback(hObject, eventdata, handles)
Position = get(handles.Joint_2,'Value');
IPosition = int64(Position);
SPosition = num2str(IPosition);
sender('1');
pause(.01);
data=sprintf('[%s,%s,%s,%s,%s,%s]',handles.CJ1, SPosition, handles.CJ3, handles.CJ4...
    , handles.CJ5, handles.CJ6);
sender(data);
pause(.1);
JointStatus = sprintf('Move Joint 2 to %s degree' , SPosition);
set ( handles.CmdStatus, 'String' , JointStatus ) ;
set ( handles.Joint_Angle_1, 'String' , SPosition ) ;
%CALL FUNCTION
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% --- Executes during object creation, after setting all properties.
function Joint_2_CreateFcn(hObject, eventdata, handles)
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function Joint_3_Callback(hObject, eventdata, handles)
Position = get(handles.Joint_3,'Value');
IPosition = int64(Position);
SPosition = num2str(IPosition);
sender('1');
pause(.01);
data=sprintf('[%s,%s,%s,%s,%s,%s]',handles.CJ1, handles.CJ2, SPosition,  handles.CJ4...
    , handles.CJ5, handles.CJ6);
sender(data);
pause(.1);
JointStatus = sprintf('Move Joint 3 to %s degree' , SPosition);
set ( handles.CmdStatus, 'String' , JointStatus ) ;
set ( handles.Joint_Angle_1, 'String' , SPosition ) ;
%CALL FUNCTION
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function Joint_3_CreateFcn(hObject, eventdata, handles)
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function Joint_4_Callback(hObject, eventdata, handles)
Position = get(handles.Joint_4,'Value');
IPosition = int64(Position);
SPosition = num2str(IPosition);
sender('1');
pause(.01);
data=sprintf('[%s,%s,%s,%s,%s,%s]',handles.CJ1, handles.CJ2,  handles.CJ3, SPosition...
    , handles.CJ5, handles.CJ6);
sender(data);
pause(.1);
JointStatus = sprintf('Move Joint 4 to %s degree' , SPosition);
set ( handles.CmdStatus, 'String' , JointStatus ) ;
set ( handles.Joint_Angle_1, 'String' , SPosition ) ;
%CALL FUNCTION
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% --- Executes during object creation, after setting all properties.
function Joint_4_CreateFcn(hObject, eventdata, handles)
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
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
%CALL FUNCTION
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% --- Executes during object creation, after setting all properties.
function Joint_5_CreateFcn(hObject, eventdata, handles)
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
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
set ( handles.CmdStatus, 'String' , JointStatus ) ;
set ( handles.Joint_Angle_1, 'String' , SPosition ) ;
%CALL FUNCTION
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slide

% --- Executes during object creation, after setting all properties.
function Joint_6_CreateFcn(hObject, eventdata, handles)
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on button press in Z_Plus_Button.
function Z_Plus_Button_Callback(hObject, eventdata, handles)
% hObject    handle to Z_Plus_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
NewZ = handles.PositionR(3)+10;
sender('0');
pause(0.01);
data=sprintf('[%d,%d,%d]',handles.PositionR(1),handles.PositionR(2),NewZ);
sender(data);
set ( handles.CmdStatus, 'String' , 'Move End Efector Robot Linear Mode Into Z+ Direction ' ) ;

% --- Executes on button press in Z_Min_Button.
function Z_Min_Button_Callback(hObject, eventdata, handles)
NewZ = handles.PositionR(3)-10;
sender('0');
pause(0.01);
data=sprintf('[%d,%d,%d]',handles.PositionR(1),handles.PositionR(2),NewZ);
sender(data);
set ( handles.CmdStatus, 'String' , 'Move End Efector Robot Linear Mode Into Z- Direction ' ) ;

% --- Executes on button press in X_Plus_Button.
function X_Plus_Button_Callback(hObject, eventdata, handles)
% hObject    handle to X_Plus_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
NewX = handles.PositionR(1)+10;
sender('0');
pause(0.01);
data=sprintf('[%d,%d,%d]',NewX, handles.PositionR(2),handles.PositionR(3));
sender(data);
set ( handles.CmdStatus, 'String' , 'Move End Efector Robot Linear Mode Into X+ Direction ' ) ;

% --- Executes on button press in X_Min_Button.
function X_Min_Button_Callback(hObject, eventdata, handles)
% hObject    handle to X_Min_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
NewX = handles.PositionR(1)-10;
sender('0');
pause(0.01);
data=sprintf('[%d,%d,%d]',NewX, handles.PositionR(2),handles.PositionR(3));
sender(data);
set ( handles.CmdStatus, 'String' , 'Move End Efector Robot Linear Mode Into X- Direction ' ) ;

% --- Executes on button press in Y_Min_Button.
function Y_Min_Button_Callback(hObject, eventdata, handles)
% hObject    handle to Y_Min_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
NewY = handles.PositionR(2)-10;
sender('0');
pause(0.01);
data=sprintf('[%d,%d,%d]',handles.PositionR(1),NewY,handles.PositionR(3));
sender(data);
set ( handles.CmdStatus, 'String' , 'Move End Efector Robot Linear Mode Into Y- Direction ' ) ;

% --- Executes on button press in Y_Plus_Button.
function Y_Plus_Button_Callback(hObject, eventdata, handles)
NewY = handles.PositionR(2)+10;
sender('0');
pause(0.01);
data=sprintf('[%d,%d,%d]',handles.PositionR(1),NewY,handles.PositionR(3));
sender(data);



% hObject    handle to Y_Plus_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set ( handles.CmdStatus, 'String' , 'Move End Efector Robot Linear Mode Into Y+ Direction ' ) ;

% --- Executes on button press in ConvEnableOn.
function ConvEnableOn_Callback(hObject, eventdata, handles)
% Hint: get(hObject,'Value') returns toggle state of ConvEnableOn

% --- Executes on button press in ConvEnableOff.
function ConvEnableOff_Callback(hObject, eventdata, handles)
% Hint: get(hObject,'Value') returns toggle state of ConvEnableOff

function CmdStatus_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of CmdStatus as text
%        str2double(get(hObject,'String')) returns contents of CmdStatus as a double

% --- Executes during object creation, after setting all properties.
function CmdStatus_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function X_Input_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of X_Input as text
%        str2double(get(hObject,'String')) returns contents of X_Input as a double

% --- Executes during object creation, after setting all properties.
function X_Input_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Z_Input_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of Z_Input as text
%        str2double(get(hObject,'String')) returns contents of Z_Input as a double


% --- Executes during object creation, after setting all properties.
function Z_Input_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit22_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of edit22 as text
%        str2double(get(hObject,'String')) returns contents of edit22 as a double


% --- Executes during object creation, after setting all properties.
function edit22_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Y_Input_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of Y_Input as text
%        str2double(get(hObject,'String')) returns contents of Y_Input as a double

% --- Executes during object creation, after setting all properties.
function Y_Input_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit24_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of edit24 as text
%        str2double(get(hObject,'String')) returns contents of edit24 as a double

% --- Executes during object creation, after setting all properties.
function edit24_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit25_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of edit25 as text
%        str2double(get(hObject,'String')) returns contents of edit25 as a double


% --- Executes during object creation, after setting all properties.
function edit25_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in GoByEndEffector.888
function GoByEndEffector_Callback(hObject, eventdata, handles)
        a= get(handles.X_Input,'String'); 
        b =get(handles.Y_Input,'String'); 
        c =get(handles.Z_Input,'String'); 
    sender('0');
    pause(0.01);
    data=sprintf('[%s,%s,%s]',a,b,c);
    sender(data);
%     fopen(handles.socket); 
%     fwrite(handles.socket,'0'); 
%     fwrite(handles.socket,handles.position);
%     fclose(handles.socket);
    
%     set(handles.pushbuttonPause, 'String', 'RESUME');
%     handles.moving =1;
% 
%     set ( handles.CmdStatus, 'String' ,...
   %     ['Move End Efector Robot Linear to ' num2str(handles.position1)] ) ;

% --- Executes on button press in LinEnable.
function LinEnable_Callback(hObject, eventdata, handles)
get(hObject,'Value')
if get(hObject,'Value')==1,
    set(findall(handles.EndEffectorGoal, '-property', 'enable'), 'enable', 'on');
else
    set(findall(handles.EndEffectorGoal, '-property', 'enable'), 'enable', 'off');
end;
% Hint: get(hObject,'Value') returns toggle state of LinEnable

function edit14_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of edit14 as text
%        str2double(get(hObject,'String')) returns contents of edit14 as a double

% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit15_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of edit15 as text
%        str2double(get(hObject,'String')) returns contents of edit15 as a double

% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit16_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of edit16 as text
%        str2double(get(hObject,'String')) returns contents of edit16 as a double


% --- Executes during object creation, after setting all properties.
function edit16_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit17_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of edit17 as text
%        str2double(get(hObject,'String')) returns contents of edit17 as a double

% --- Executes during object creation, after setting all properties.
function edit17_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit18_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of edit18 as text
%        str2double(get(hObject,'String')) returns contents of edit18 as a double

% --- Executes during object creation, after setting all properties.
function edit18_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit19_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function edit19_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in GoByJoints.
function GoByJoints_Callback(hObject, eventdata, handles)
% hObject    handle to GoByJoints (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set ( handles.CmdStatus, 'String' , 'Move Robot In Axis Mode Into Axis Angle Target of Each Joint ' ) ;

% --- Executes on button press in JointEnable.
function JointEnable_Callback(hObject, eventdata, handles)
% hObject    handle to JointEnable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
get(hObject,'Value')
if get(hObject,'Value')==1,
    set(handles.Joint_GO, 'enable', 'on');
else
    set(handles.Joint_GO, 'enable', 'off');
end;
% Hint: get(hObject,'Value') returns toggle state of JointEnable

% --- Executes on button press in OutEnable.
function OutEnable_Callback(hObject, eventdata, handles)
% hObject    handle to OutEnable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
get(hObject,'Value')
if get(hObject,'Value')==1,
    set(findall(handles.ConvEnable, '-property', 'enable'), 'enable', 'on');
    set(findall(handles.ConvDirection, '-property', 'enable'), 'enable', 'on');
    set(findall(handles.VacPump, '-property', 'enable'), 'enable', 'on');
    set(findall(handles.SolValve, '-property', 'enable'), 'enable', 'on');
else
    set(findall(handles.ConvEnable, '-property', 'enable'), 'enable', 'off')
    set(findall(handles.ConvDirection, '-property', 'enable'), 'enable', 'off');
    set(findall(handles.VacPump, '-property', 'enable'), 'enable', 'off');
    set(findall(handles.SolValve, '-property', 'enable'), 'enable', 'off');
end;

% Hint: get(hObject,'Value') returns toggle state of OutEnable

function update_display(hObject,eventdata,hfigure,handles)
% Timer timer1 callback, called each time timer iterates.
% Gets surface Z data, adds noise, and writes it back to surface object.

global imgConv imgTable
imgConv=snapshot(handles.mycam);
axes(handles.ConvCam);
imshow(imgConv);

imgTable=snapshot(handles.mycam);
axes(handles.TableCam);
imshow(imgTable);
%guidata(hObject, handles);

% --- Executes on button press in ShowIm.
function ShowIm_Callback(hObject, eventdata, handles)
% hObject    handle to ShowIm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
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

% --- Executes on button press in StopIm.
function StopIm_Callback(hObject, eventdata, handles)
% hObject    handle to StopIm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% set ( handles.CmdStatus, 'String' , 'Stop Showing Video From Camera Input' ) ;
% stoppreview(handles.vid2);
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
%closePreview(handles.vid1);
%clear('handles.vid1');

% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(hObject);
% clear handles.vid1;
% clear handles.vid2;
delete(handles.vid1);
%delete(handles.vid2);
delete(handles.timer);
% delete(instrfind);
% delete(hObject);
% delete(gcf);

% Hint: delete(hObject) closes the figure



% --- Executes on button press in ImCapt.
function ImCapt_Callback(hObject, eventdata, handles)
% set(handles.vid1,'VideoResolution','1600 900');
% handles.vid1
% % % % % imgTable=getsnapshot(handles.vid1);
 imgConv=getsnapshot(handles.vid2);% 1.Get snap shot
% im=imread('IMG_003.jpg');
% % % % % im = imgTable;
% % % % % c=detect(im);
% % % % % set(handles.axes3); 
% % % % % handle.c =c;
% % % % % set(handle.ChocTable,'userdata',handle.c) ;
% % % % % hold on;

plotBoxConv(imgConv);
set(handles.axes3);

hold off;



% c= DetectChoc(imgTable);
% 
%uistack(handle.axes3,'top');
% axes(handles.axes3);
% plot(handles.axes3,40, 50,'*r');
% set(handles.axes3,'color','none');


%set(handles.axes3,'color','none','Parent');



%start(handles.timer)

% --- Executes on button press in SendOutput.
function SendOutput_Callback(hObject, eventdata, handles)
% hObject    handle to SendOutput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
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
%handles.IO = [cON,dir,vac,sol,handles.speed,0];
sender('3');
pause(0.01);
%idisp(num2str(handles.IO));
data=sprintf('[%s,%s,%s,%s,%s,0]',handles.Vac,handles.Sol,handles.CRun,handles.CDir,handles.Speed);
sender(data);

% fopen(handles.socket);
% fwrite(handles.socket,'3');
% fwrite(handles.socket, handles.IO);
% fclose(handles.socket);


% CALL FUNCTION ROBOT STUDIO
CommandStatus = sprintf('Set Output Conveyor Enable = %d, Conveyor Direction = %str, Vacuum Pump = %str, Solenoid Valve = %str', CE, VP, CD, SV);
set ( handles.CmdStatus, 'String' , CommandStatus ) ;

function edit27_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of Joint_Angle_1 as text
%        str2double(get(hObject,'String')) returns contents of Joint_Angle_1 as a double

% --- Executes during object creation, after setting all properties.
function edit27_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Joint_Angle_3_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of Joint_Angle_3 as text
%        str2double(get(hObject,'String')) returns contents of Joint_Angle_3 as a double

% --- Executes during object creation, after setting all properties.
function Joint_Angle_3_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit29_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of Joint_Angle_6 as text
%        str2double(get(hObject,'String')) returns contents of Joint_Angle_6 as a double

% --- Executes during object creation, after setting all properties.
function edit29_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit30_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of Joint_Angle_2 as text
%        str2double(get(hObject,'String')) returns contents of Joint_Angle_2 as a double

% --- Executes during object creation, after setting all properties.
function edit30_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit31_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of Joint_Angle_4 as text
%        str2double(get(hObject,'String')) returns contents of Joint_Angle_4 as a double

% --- Executes during object creation, after setting all properties.
function edit31_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit32_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of Joint_Angle_5 as text
%        str2double(get(hObject,'String')) returns contents of Joint_Angle_5 as a double

% --- Executes during object creation, after setting all properties.
function edit32_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in Joint_GO.
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
% fopen(handles.socket);
% fwrite(handles.socket, '1');
% fwrite(handles.socket, handles.joint);
% fclose(handles.socket);

% set(set, handles.Joint_1, 'value', handles.joint(1));
% set(set, handles.Joint_2, 'value', handles.joint(2));
% set(set, handles.Joint_3, 'value', handles.joint(3));
% set(set, handles.Joint_4, 'value', handles.joint(4));
% set(set, handles.Joint_5, 'value', handles.joint(5));
% set(set, handles.Joint_6, 'value', handles.joint(6));


JointData = sprintf('Move In Jont Mode Into J1 = %d ; J2 = %d ; J3 = %d ; J4 = %d ; J5 = %d ; J6 = %d' , J1,J2,J3,J4,J5,J6);
set ( handles.CmdStatus, 'String' , JointData ) ;
% CALL FUNCTION FOR ROBOT STUDIO


% --- Executes on key press with focus on figure1 or any of its controls.
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


% --- Executes on key release with focus on figure1 or any of its controls.
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

function Changedisplay(hObject,eventdata,hfigure,handles)
% Timer timer1 callback, called each time timer iterates.
% Gets surface Z data, adds noise, and writes it back to surface object.
[handles.PositionR, handles.JointR, handles.IOR] = Take_Rob_Status();
%disp(handles.PositionR);
data = sprintf('X = %d Y = %d Z = %d',handles.PositionR(1),handles.PositionR(2),handles.PositionR(3));
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
    ,handles.IOR(1),handles.IOR(2),handles.IOR(3),handles.IOR(4),handles.IOR(5));
set(handles.CurrentIO,'String',data);
drawnow();
%disp(handles.JointR);
%disp(handles.IOR);

% --- Executes on button press in GetC_Coordinate.
function GetC_Coordinate_Callback(hObject, eventdata, handles)
[X Y]=ginput(1);
XR=Y;
YR=-800+X;
XR=XR*1.5;
YR=YR*1.5;
texboxStatus = sprintf('X = %d  Y = %d', X, Y);
set(handles.C_Coordinate,'String',texboxStatus); 
    sender('0');
    pause(0.01);
    data=sprintf('[%s,%s,150]',XR,YR);
    sender(data);

% --- Executes on button press in Get_T_Coordinate.
function Get_T_Coordinate_Callback(hObject, eventdata, handles)
[X Y]=ginput(1);
XR=900-Y;
YR=800-X;
XR=XR*1.5;
YR=YR*1.5;
texboxStatus = sprintf('X = %d  Y = %d', X, Y);
set(handles.C_Coordinate,'String',texboxStatus);

function C_Coordinate_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of C_Coordinate as text
%        str2double(get(hObject,'String')) returns contents of C_Coordinate as a double

% --- Executes during object creation, after setting all properties.
function C_Coordinate_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function T_Coordinate_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of T_Coordinate as text
%        str2double(get(hObject,'String')) returns contents of T_Coordinate as a double

% --- Executes during object creation, after setting all properties.
function T_Coordinate_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in jogEnable.
function jogEnable_Callback(hObject, eventdata, handles)
% Hint: get(hObject,'Value') returns toggle state of jogEnable



% --- Executes during object creation, after setting all properties.
function ChocTable_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ChocTable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on slider movement.
function slider25_Callback(hObject, eventdata, handles)
% hObject    handle to slider25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider25_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in SpeedEnable.
function SpeedEnable_Callback(hObject, eventdata, handles)
% hObject    handle to SpeedEnable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SpeedEnable



function editSpeed_Callback(hObject, eventdata, handles)
% hObject    handle to editSpeed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editSpeed as text
%        str2double(get(hObject,'String')) returns contents of editSpeed as a double


% --- Executes during object creation, after setting all properties.
function editSpeed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editSpeed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonSpeed.
function pushbuttonSpeed_Callback(hObject, eventdata, handles)
% handles.speed = get(handles.listboxSpeed, 'String');
% handles.IO = handles.IOR;
% handles.IO(5) = handles.speed; 
% 
% fopen(handles.socket);
% fwrite(handles.socket, 1);
% fwrite(handles.socket, handles.IO );
% fclose(handles.socket);
handles.Speed= get(handles.editSpeed, 'string');
sender('3');
pause(0.01);
%idisp(num2str(handles.IO));
data=sprintf('[%s,%s,%s,%s,%s,0]',handles.Vac,handles.Sol,handles.CRun,handles.CDir,handles.Speed);
sender(data);


% hObject    handle to pushbuttonSpeed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in listboxSpeed.
function listboxSpeed_Callback(hObject, eventdata, handles)
% hObject    handle to listboxSpeed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listboxSpeed contents as cell array
 handles.Speed = contents{get(hObject,'Value')} 
 %returns selected item from listboxSpeed


% --- Executes during object creation, after setting all properties.
function listboxSpeed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listboxSpeed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonPause.
function pushbuttonPause_Callback(hObject, eventdata, handles)
% fopen(handles.socket);    
% if  handles.moving==1
%         fwrite(handles.socket, 'S1');
%         handles.moving = 0;
%         set(handles.pushbuttonPause, 'String', 'RESUME');
% else 
%         fwrite(handles.socket, 'S2');
%         handles.moving = 0;
%         
% end
%fclose(handles.socket);

 sender('S1');

 

% hObject    handle to pushbuttonPause (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on mouse press over axes background.
function axes3_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when selected cell(s) is changed in uitable5.
function uitable5_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to uitable5 (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)



function CurrentPosition_Callback(hObject, eventdata, handles)
% hObject    handle to CurrentPosition (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CurrentPosition as text
%        str2double(get(hObject,'String')) returns contents of CurrentPosition as a double


% --- Executes during object creation, after setting all properties.
function CurrentPosition_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CurrentPosition (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function CurrentJoint_Callback(hObject, eventdata, handles)
% hObject    handle to CurrentJoint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CurrentJoint as text
%        str2double(get(hObject,'String')) returns contents of CurrentJoint as a double


% --- Executes during object creation, after setting all properties.
function CurrentJoint_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CurrentJoint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function CurrentIO_Callback(hObject, eventdata, handles)
% hObject    handle to CurrentIO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CurrentIO as text
%        str2double(get(hObject,'String')) returns contents of CurrentIO as a double


% --- Executes during object creation, after setting all properties.
function CurrentIO_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CurrentIO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton28.
function pushbutton28_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
start(handles.timer);


% --- Executes on button press in CalibPos.
function CalibPos_Callback(hObject, eventdata, handles)
sender('2');


% --- Executes on button press in pushbutton30.
function pushbutton30_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sender('S2');


% --- Executes on button press in pushbutton31.
function pushbutton31_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function pushbuttonSpeed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbuttonSpeed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton32.
function pushbutton32_Callback(hObject, eventdata, handles)
    a= get(handles.X_Input,'String'); 
    b =get(handles.Y_Input,'String'); 
    c =get(handles.Z_Input,'String'); 
    sender('4');
    pause(0.01);
    data=sprintf('[%s,%s,%s]',a,b,c);
    sender(data);


% --- Executes on button press in UpdateJoint.
function UpdateJoint_Callback(hObject, eventdata, handles)
% hObject    handle to UpdateJoint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.Joint_1,'value',handles.JointR(1));
set(handles.Joint_2,'value',handles.JointR(2));
set(handles.Joint_3,'value',handles.JointR(3));
set(handles.Joint_4,'value',handles.JointR(4));
set(handles.Joint_5,'value',handles.JointR(5));
set(handles.Joint_6,'value',handles.JointR(6));



% --- Executes on button press in pushbutton34.
function pushbutton34_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
