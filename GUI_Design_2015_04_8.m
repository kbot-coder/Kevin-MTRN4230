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
handles.ConveyorEnable = 1;

handles.output = hObject;

%---------------------------------------------------
set(findall(handles.ConvEnable, '-property', 'enable'), 'enable', 'off');
set(findall(handles.ConvDirection, '-property', 'enable'), 'enable', 'off');
set(findall(handles.VacPump, '-property', 'enable'), 'enable', 'off');
set(findall(handles.SolValve, '-property', 'enable'), 'enable', 'off');
set(findall(handles.JointPositionInput, '-property', 'enable'), 'enable', 'off');
set(findall(handles.EndEffectorGoal, '-property', 'enable'), 'enable', 'off');

handles.vid  = videoinput('macvideo', 1);

handles.timer= timer(...
    'ExecutionMode', 'fixedRate', ...       % Run timer repeatedly
    'Period', 0.1, ...                        % Initial period is 1 sec.
    'TimerFcn', {@Changedisplay,hObject,handles}); % Specify callback function

% Update handles structure
guidata(hObject, handles);
% UIWAIT makes GUI_Design_2015_04_8 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


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
function slider11_Callback(hObject, eventdata, handles)
set ( handles.CmdStatus, 'String' , 'Move Joint 1 to --- degree' ) ;
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% --- Executes during object creation, after setting all properties.
function slider11_CreateFcn(hObject, eventdata, handles)
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function slider12_Callback(hObject, eventdata, handles)
set ( handles.CmdStatus, 'String' , 'Move Joint 4 to --- degree' ) ;
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% --- Executes during object creation, after setting all properties.
function slider12_CreateFcn(hObject, eventdata, handles)
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function slider13_Callback(hObject, eventdata, handles)
set ( handles.CmdStatus, 'String' , 'Move Joint 5 to --- degree' ) ;
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% --- Executes during object creation, after setting all properties.
function slider13_CreateFcn(hObject, eventdata, handles)
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function slider14_Callback(hObject, eventdata, handles)
set ( handles.CmdStatus, 'String' , 'Move Joint 6 to --- degree' ) ;
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slide

% --- Executes during object creation, after setting all properties.
function slider14_CreateFcn(hObject, eventdata, handles)
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function slider15_Callback(hObject, eventdata, handles)
set ( handles.CmdStatus, 'String' , 'Move Joint 2 to --- degree' ) ;
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% --- Executes during object creation, after setting all properties.
function slider15_CreateFcn(hObject, eventdata, handles)
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function slider16_Callback(hObject, eventdata, handles)
set ( handles.CmdStatus, 'String' , 'Move Joint 3 to --- degree' ) ;
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% --- Executes during object creation, after setting all properties.
function slider16_CreateFcn(hObject, eventdata, handles)
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on button press in Z_Plus_Button.
function Z_Plus_Button_Callback(hObject, eventdata, handles)
% hObject    handle to Z_Plus_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set ( handles.CmdStatus, 'String' , 'Move End Efector Robot Linear Mode Into Z+ Direction ' ) ;

% --- Executes on button press in Z_Min_Button.
function Z_Min_Button_Callback(hObject, eventdata, handles)
% hObject    handle to Z_Min_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set ( handles.CmdStatus, 'String' , 'Move End Efector Robot Linear Mode Into Z- Direction ' ) ;

% --- Executes on button press in X_Plus_Button.
function X_Plus_Button_Callback(hObject, eventdata, handles)
% hObject    handle to X_Plus_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set ( handles.CmdStatus, 'String' , 'Move End Efector Robot Linear Mode Into X+ Direction ' ) ;

% --- Executes on button press in X_Min_Button.
function X_Min_Button_Callback(hObject, eventdata, handles)
% hObject    handle to X_Min_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set ( handles.CmdStatus, 'String' , 'Move End Efector Robot Linear Mode Into X- Direction ' ) ;

% --- Executes on button press in Y_Min_Button.
function Y_Min_Button_Callback(hObject, eventdata, handles)
% hObject    handle to Y_Min_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set ( handles.CmdStatus, 'String' , 'Move End Efector Robot Linear Mode Into Y- Direction ' ) ;

% --- Executes on button press in Y_Plus_Button.
function Y_Plus_Button_Callback(hObject, eventdata, handles)
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

function edit20_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of edit20 as text
%        str2double(get(hObject,'String')) returns contents of edit20 as a double

% --- Executes during object creation, after setting all properties.
function edit20_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit21_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of edit21 as text
%        str2double(get(hObject,'String')) returns contents of edit21 as a double


% --- Executes during object creation, after setting all properties.
function edit21_CreateFcn(hObject, eventdata, handles)
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

function edit23_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of edit23 as text
%        str2double(get(hObject,'String')) returns contents of edit23 as a double

% --- Executes during object creation, after setting all properties.
function edit23_CreateFcn(hObject, eventdata, handles)
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

% --- Executes on button press in GoByEndEffector.
function GoByEndEffector_Callback(hObject, eventdata, handles)
set ( handles.CmdStatus, 'String' , 'Move End Efector Robot Linear Mode Into Target ' ) ;

% --- Executes on button press in checkbox16.
function checkbox16_Callback(hObject, eventdata, handles)
get(hObject,'Value')
if get(hObject,'Value')==1,
    set(findall(handles.EndEffectorGoal, '-property', 'enable'), 'enable', 'on');
else
    set(findall(handles.EndEffectorGoal, '-property', 'enable'), 'enable', 'off');
end;
% Hint: get(hObject,'Value') returns toggle state of checkbox16

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
% Hints: get(hObject,'String') returns contents of edit19 as text
%        str2double(get(hObject,'String')) returns contents of edit19 as a double

% --- Executes during object creation, after setting all properties.
function edit19_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in GoByJoints.
function GoByJoints_Callback(hObject, eventdata, handles)
% hObject    handle to GoByJoints (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set ( handles.CmdStatus, 'String' , 'Move Robot In Axis Mode Into Axis Angle Target of Each Joint ' ) ;

% --- Executes on button press in checkbox15.
function checkbox15_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
get(hObject,'Value')
if get(hObject,'Value')==1,
    set(findall(handles.JointPositionInput, '-property', 'enable'), 'enable', 'on');
else
    set(findall(handles.JointPositionInput, '-property', 'enable'), 'enable', 'off');
end;
% Hint: get(hObject,'Value') returns toggle state of checkbox15

% --- Executes on button press in checkbox14.
function checkbox14_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox14 (see GCBO)
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

% Hint: get(hObject,'Value') returns toggle state of checkbox14

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
handles.vid .FramesPerTrigger = 1;
handles.vid .ReturnedColorspace = 'rgb';
triggerconfig(handles.vid , 'manual');
vidRes = get(handles.vid , 'VideoResolution');
imWidth = vidRes(1);
imHeight = vidRes(2);
nBands = get(handles.vid , 'NumberOfBands');
hImage = image(zeros(imHeight, imWidth, nBands), 'parent', handles.ConvCam)
preview(handles.vid , hImage);

% --- Executes on button press in StopIm.
function StopIm_Callback(hObject, eventdata, handles)
% hObject    handle to StopIm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set ( handles.CmdStatus, 'String' , 'Stop Showing Video From Camera Input' ) ;
stoppreview(handles.vid);
handles.vid .FramesPerTrigger = 1;
handles.vid .ReturnedColorspace = 'rgb';
triggerconfig(handles.vid , 'manual');
vidRes = get(handles.vid , 'VideoResolution');
imWidth = vidRes(1);
imHeight = vidRes(2);
nBands = get(handles.vid , 'NumberOfBands');
hImage2 = image(zeros(imHeight, imWidth, nBands), 'parent', handles.TableCam)
preview(handles.vid , hImage2);

% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
stop(handles.timer)
delete(hObject);


% --- Executes on button press in ImCapt.
function ImCapt_Callback(hObject, eventdata, handles)
start(handles.timer)

% --- Executes on button press in SendOutput.
function SendOutput_Callback(hObject, eventdata, handles)
% hObject    handle to SendOutput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
switch get(get(handles.ConvEnable,'SelectedObject'),'Tag')
    case 'ConvEnableOn',  CE='ON';
    case 'ConvEnableOff', CE='OFF';
end

switch get(get(handles.VacPump,'SelectedObject'),'Tag')
    case 'VacPumpOn',  VP='ONN';
    case 'VacPumpOff', VP='OFF';
end

switch get(get(handles.ConvDirection,'SelectedObject'),'Tag')
    case 'ConvDirectionFW',  CD='Forward';
    case 'ConvDirectionBW', CD='Backward';
end

switch get(get(handles.SolValve,'SelectedObject'),'Tag')
    case 'SolValveOn',  SV='ON';
    case 'SolValveOff', SV='OFF';
end

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

% --- Executes on button press in pushbutton21.
function pushbutton21_Callback(hObject, eventdata, handles)
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
imgTable=getsnapshot(handles.vid);
axes(handles.TableCam);
imshow(imgTable);

% --- Executes on button press in GetC_Coordinate.
function GetC_Coordinate_Callback(hObject, eventdata, handles)
[X,Y]=ginput(1);
texboxStatus = sprintf('X = %d  Y = %d', X, Y);
set(handles.C_Coordinate,'String',texboxStatus);

% --- Executes on button press in Get_T_Coordinate.
function Get_T_Coordinate_Callback(hObject, eventdata, handles)
[X,Y] = ginput(1);
texboxStatus = sprintf('X = %d  Y = %d', X, Y);
set(handles.T_Coordinate,'String',texboxStatus);

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


% --- Executes on slider movement.
function slider17_Callback(hObject, eventdata, handles)
% hObject    handle to slider17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
