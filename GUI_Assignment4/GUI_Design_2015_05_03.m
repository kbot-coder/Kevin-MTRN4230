% DONT TOUCH ANYTHING INSIDE THE BOX HERE
%==========================================================================
function varargout = GUI_Design_2015_05_03(varargin)

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_Design_2015_05_03_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_Design_2015_05_03_OutputFcn, ...
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
% Executes just before GUI_Design_2015_05_03 is made visible.
%--------------------------------------------------------------------------
function GUI_Design_2015_05_03_OpeningFcn(hObject, eventdata, handles, varargin)
% Set All Handles Variable
handles.output = hObject;

%--------Innitialize All Handles Variable That Will be Used----------------
%VALUES
handles.moving      = 0;                % Indicate the status of the robot in moving or not
handles.position    = [ 0,0,0]; 
handles.joint       = [ 0,0,0,0,0,0];
handles.Speed ='10';
handles.pause=0;

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
set(handles.axes3, 'Xlim', [0,1600], 'YLim', [0 900]); % Setting limit axes tobe respect to the image resolution
set(handles.axes4, 'Xlim', [0,640], 'YLim', [0 480]);
set(handles.axes3,'xtick',[],'ytick',[]);       % Supress the axes3 axis value
set(handles.axes4,'xtick',[],'ytick',[]);       % Supress the axes4 axis value
set(handles.ConvCam,'xtick',[],'ytick',[]);     % Supress the ConvCam axis value
set(handles.TableCam,'xtick',[],'ytick',[]);    % Supress the TableCam axis value

% axes(handles.axes4);
% imshow(imread('converyor.jpg'));
% axes(handles.axes3);
% imshow(imrot90(imread('empty.png'),2));
% set(handles.ConvCam,'Visible','off');
% set(handles.TableCam,'Visible','off');

%Managing handles timer
handles.timer= timer(...
    'ExecutionMode', 'fixedRate', ...               % Run timer repeatedly in fix rate
    'Period', 5, ...                              % Initial period is 0.1 sec.
    'TimerFcn', {@DetectChocolates,hObject,handles});  % Specify callback function that executed when timer iterated


handles.timer1= timer(...
    'ExecutionMode', 'fixedRate', ...               % Run timer repeatedly in fix rate
    'Period', 0.5, ...                              % Initial period is 0.1 sec.
    'TimerFcn', {@UpdateConnection,hObject,handles});  % Specify callback function that executed when timer iterated

% Update handles structure
guidata(hObject, handles);
% UIWAIT makes GUI_Design_2015_05_03 wait for user response (see UIRESUME)
%uiwait(handles.figure1);
%--------------------------------------------------------------------------


% --- Outputs from this function are returned to the command line.
function varargout = GUI_Design_2015_05_03_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;
% -----------------------------------------------------------------------


%--------------------------------------------------------------------------
% Managing Edit Texbox Components
%--------------------------------------------------------------------------

%-------------------Speed Setting Input------------------------------------

function editSpeed_Callback(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
function editSpeed_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%-------------------Command Output & Status Robot--------------------------


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
% Managing Button Object
%--------------------------------------------------------------------------


%------------------------Setting Speed Button------------------------------
function SpeedButton_Callback(hObject, eventdata, handles)
handles.Speed= get(handles.editSpeed, 'string');    % Get speed data input from the textbox
sender('3');                                        % Call sender function to send '3' as speed change mode
pause(0.01);
data=sprintf('[%s,%s,%s,%s,%s,0]'...                % Set data tobe sended as string
    ,handles.Vac,handles.Sol...
    ,handles.CRun,handles.CDir,handles.Speed);
sender(data);                                       % Call sender function to send speed data


%--------------------------Click & GO Button-------------------------------

% Executed when Click & GO button on Table camera pressed 
function GetC_Coordinate_Callback(hObject, eventdata, handles)
[xx, yy]=ginput(1);                                         % Get input coordinate from the table camera frame
[Xr , Yr] = conveyor2robot(xx,yy);
texboxStatus = sprintf('GO to  X = %d  Y = %d', Xr, Yr);    % Set data to be showed
set(handles.C_Coordinate,'String',texboxStatus);            % Show value into textbox


% Executed when Click & GO button on Table camera pressed 
function Get_T_Coordinate_Callback(hObject, eventdata, handles)
[xx, yy]=ginput(1); 
data=sprintf('X = %d Y = %d',xx, yy);
set(handles.T_Coordinate,'string',data);
Data = get(handles.ChocTable,'Data');
dataSize = size(Data);
selectedData = [];
for i=1:dataSize(1),
    in = checkPoint(xx , yy , Data(i,1) , Data(i,2),  -Data(i,3))
    if in == 1,
        selectedData = Data(i,:);
    end
end;
set(handles.selectedChocolateTable,'Data',selectedData);
axes(handles.axes3); cla; 
try
    plotRectangle(selectedData(1,1) , selectedData(1,2),  -selectedData(1,3));
    [Xr , Yr]=table2robot(selectedData(1,1) , selectedData(1,2));
    datastring = sprintf('GO to X = %d , Y = %d , Z = 150',Xr,Yr);
    set(handles.T_Coordinate,'string',datastring);
catch
    [Xr , Yr]=table2robot(xx , yy);
    datastring = sprintf('GO to X = %d , Y = %d , Z = 150',Xr,Yr);
    set(handles.T_Coordinate,'string',datastring);
    errordlg('No chocolate detected on that particular area');
end




% ------------------Activate Timer To Connect Robot Studio-----------------

function connectButton_Callback(hObject, eventdata, handles)
disp(handles.Connect)
if handles.Connect == 0,        % When it hasn't connected yet
    %Managing Video handles
    [handles.vid1,handles.vid2,videoConnect] = ConnectToCamera;
    if videoConnect==1,
        set(handles.connectButton,'String', 'Disconnect'); % Turn the button into connect button
        handles.Connect = 1;        % make the connection status = 1 ---> Connected
        showImage(hObject,handles)
    end              
    start(handles.timer1);       % Start timer 1 to connect with robot studio periodically      
else                            % When it already connected
    stop(handles.timer1);        
    stop(handles.vid1);         % stop video 2 to disconnect from table camera
    stop(handles.vid2);         % stop video 2 to disconnect from conveyor camera
    delete(handles.timer1);        % Stop timer to stop connection wit the robot
    delete(handles.vid1);         % stop video 2 to disconnect from table camera
    delete(handles.vid2);
    handles.Connect = 0;        % make the connection status = 0 ---> unconnected
    set(handles.connectButton,'String', 'Connect'); % Turn the button into connect button
end
guidata(hObject, handles);


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


%------------------- Managing Table Object---------------------------------
% Creating table object to show the list of detected chocolate
function ChocTable_CreateFcn(hObject, eventdata, handles)


%------------------------TIMER FUNCTION------------------------------------
% This function will be executed every time timer object iterated
%--------------------------------------------------------------------------

function UpdateConnection(hObject,eventdata,hfigure,handles)
disp('Ping Robot');
%guidata(hObject, handles);



function DetectChocolates(hObject,eventdata,hfigure,handles)
                  
drawnow();  % Push matlab to show the result before executing another function
%guidata(hObject, handles);


%--------------------------------------------------------------------------
% Managing Close GUI
%--------------------------------------------------------------------------
% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
delete(hObject);
delete(handles.vid1);   % Delete object input vodeo 1 before closing the GUI
delete(handles.vid2);   % Delete object input vodeo 2 before closing the GUI
delete(handles.timer1);  % Delete object timer before closing the GUI
delete(handles.timer);  % Delete object timer before closing the GUI

function showImage(hObject,handles)

    [imHeight,imWidth, nBands] = SetImage(handles.vid1,handles.vid1);
    axes(handles.TableCam);                              % set axes ConvCam for showing video 1
    hImage1 = image(zeros(imHeight(1),imWidth(1), nBands(1)), ... % set image frame as a the size of video image as a base for showing 
        'parent', handles.TableCam);                     % video image
    preview(handles.vid1,hImage1);                       % show video image 1 on hImage frame
    
    axes(handles.ConvCam);                             % set axes TableCam for showing video 2
    hImage2 = image(zeros(imHeight(2), imWidth(2), nBands(2)), ... % set image frame as a the size of video image as a base for showing 
        'parent', handles.ConvCam);                    % video image
    preview(handles.vid2,hImage2); 
    
    guidata(hObject, handles);


% --- Executes when selected cell(s) is changed in ChocTable.
function ChocTable_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to ChocTable (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
handles.selectedRow = eventdata.Indices(1);
Data = get(handles.ChocTable,'Data');
selectedData = Data(handles.selectedRow,:);
set(handles.selectedChocolateTable,'Data',selectedData);
axes(handles.axes3); cla;
plotRectangle(selectedData(1,1) , selectedData(1,2),  -selectedData(1,3))
disp(eventdata);


% --- Executes on button press in pushbutton36.
function pushbutton36_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in selectGroupButton.
function selectGroupButton_Callback(hObject, eventdata, handles)
Data = get(handles.ChocTable,'Data');
flavourColoum = Data(:,6); 
switch get(get(handles.selectGroup,'SelectedObject'),'Tag')
    case 'selectMilk',  
        milkRow = find(flavourColoum==1);
        selectedData = Data(milkRow,:);
        set(handles.selectedChocolateTable,'Data',selectedData);
    case 'selectDark',  
        darkRow = find(flavourColoum==2);
        selectedData = Data(darkRow,:);
        set(handles.selectedChocolateTable,'Data',selectedData);
    case 'selectOrange',  
        orangeRow = find(flavourColoum==3);
        selectedData = Data(orangeRow,:);
        set(handles.selectedChocolateTable,'Data',selectedData);
    case 'selectMint',  
        mintRow = find(flavourColoum==4);
        selectedData = Data(mintRow,:);
        set(handles.selectedChocolateTable,'Data',selectedData);
    case 'selectBack',  
        backRow = find(flavourColoum==0);
        selectedData = Data(backRow,:);
        set(handles.selectedChocolateTable,'Data',selectedData);
end
dataSize = size(selectedData);
axes(handles.axes3); cla;
for i=1:dataSize(1),    
    plotRectangle(selectedData(i,1) , selectedData(i,2),  -selectedData(i,3))
    hold on;
end


% --- Executes on button press in pushbutton38.
function pushbutton38_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton38 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Capture table camera, process it, detect choclate, & show it in axes 3
%imgTable=getsnapshot(handles.vid1);     % capture image from video 1 (Table camera)
imgTable=imread('IMG_013.jpg');
axes(handles.TableCam);
image(imgTable);
set(handles.TableCam,'xtick',[],'ytick',[]);       % Supress the axes3 axis value

axes(handles.axes3);
set(handles.axes3,'color','none');
c = findChoc((imgTable));   % HERE THE CHOC DETECTION
set(handles.axes3,'xtick',[],'ytick',[]);       % Supress the axes3 axis value

handle.c =c;                            % data chocolate
set(handles.ChocTable,'Data',handle.c); % show data chocolate on the table 

% Capture conveyor camera, process it, detect the box & show it in axes 4
%imgConv=getsnapshot(handles.vid2);      % capture image from video 2 (conveyor camera)
imgConv=imread('converyor3.jpg');
axes(handles.ConvCam);
image(imgConv);
set(handles.ConvCam,'xtick',[],'ytick',[]);
axes(handles.axes4);
set(handles.axes4,'color','none'); 
%plotBoxConv(imgConv);                   % call function plotBoxConv to detect box
set(handles.axes4,'xtick',[],'ytick',[]);



% --- Executes on button press in runButton.
function runButton_Callback(hObject, eventdata, handles)
% hObject    handle to runButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function figure1_WindowKeyPressFcn(hObject, eventdata, handles)

function figure1_WindowKeyReleaseFcn(hObject, eventdata, handles)
