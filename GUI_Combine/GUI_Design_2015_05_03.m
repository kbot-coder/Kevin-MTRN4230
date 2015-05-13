% DONT TOUCH ANYTHING INSIDE THE BOX HERE
%% ========================================================================
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
%% ========================================================================


%--------------------------------------------------------------------------
% Executes just before GUI_Design_2015_05_03 is made visible.
%--------------------------------------------------------------------------
%% INITIALISATIONS VAR
function GUI_Design_2015_05_03_OpeningFcn(hObject, eventdata, handles, varargin)
% Set All Handles Variable
handles.output = hObject;
clc;
disp('------------   START   -----------');
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

% Status of boxes and chocolates 
% Before GUI connected & syncronize with Robot Studio 
handles.box  ={};
handles.b    = [];
handles.bSelect = [0 0]; %[box, region]

handles.pickTarget = [];
handles.placeTarget = [];
handles.selectedChocolate = [];
handles.zTable = 150;
handles.placeTable = [];
handles.robotStatus = 'GREEN';

% Managing proper ties of Axis handles for showing the video & image
% processing result
% axes3 for showing detected choclate
% axesConvDetect for showing detected box
% axesConvCam for showing conveyor camera
% TableCam for showing table camera                      
set(handles.axes3, 'Xlim', [0,1600], 'YLim', [0 900]); % Setting limit axes tobe respect to the image resolution
set(handles.axes3,'xtick',[],'ytick',[]);       % Supress the axes3 axis value
set(handles.axesConvDetect,'xtick',[],'ytick',[]);       % Supress the axes4 axis value
set(handles.axesConvCam,'xtick',[],'ytick',[]);     % Supress the ConvCam axis value
set(handles.TableCam,'xtick',[],'ytick',[]);    % Supress the TableCam axis value
set(handles.axesConvDetect, 'Xlim', [0,640], 'YLim', [0 480]);

set(handles.axesTableSelect,'Xlim', [0,1600], 'YLim', [0 900]);
set(handles.placeTargetAxes,'Xlim', [0,1600], 'YLim', [0 900]);
set(handles.placeTargetAxes,'xtick',[],'ytick',[]);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes(handles.axesConnectivity);
load('conn.mat');   % the image of connectivity
imshow(imDisconnect);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Managing handles timer
handles.timer= timer(...
    'ExecutionMode', 'fixedRate', ...               % Run timer repeatedly in fix rate
    'Period', 5, ...                              % Initial period is 0.1 sec.
    'TimerFcn', {@DetectChocolates,hObject,handles});  % Specify callback function that executed when timer iterated

handles.timer1= timer(...
    'ExecutionMode', 'fixedRate', ...               % Run timer repeatedly in fix rate
    'Period', 0.5, ...                              % Initial period is 0.1 sec.
    'TimerFcn', {@UpdateConnection,hObject,handles});  % Specify callback function that executed when timer iterated

handles.chocolateTimer= timer(...
    'ExecutionMode', 'fixedRate', ...               % Run timer repeatedly in fix rate
    'Period', 10, ...                              % Initial period is 0.1 sec.
    'TimerFcn', {@UpdateChocolate,hObject,handles});  % Specify callback function that executed when timer iterated

% Update handles structure
guidata(hObject, handles);
% UIWAIT makes GUI_Design_2015_05_03 wait for user response (see UIRESUME)
%uiwait(handles.figure1);
%% ------------------------------------------------------------------------

% --- Outputs from this function are returned to the command line.
function varargout = GUI_Design_2015_05_03_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;
% -----------------------------------------------------------------------

%--------------------------------------------------------------------------
% Managing Edit Texbox Components
%--------------------------------------------------------------------------
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

%--------------------------------------------------------------------------



%--------------------------------------------------------------------------
% Managing Button Object
%--------------------------------------------------------------------------

%--------------------------Click & GO Button-------------------------------

% Executed when Click & GO button on Table camera pressed 
function GetC_Coordinate_Callback(hObject, eventdata, handles)
set(handles.editCommand,'string', 'Press ENTER to cancel' );
[X, Y]=ginput(1);                                   % Get input coordinate from the table camera frame
XR=900-Y; YR=X; XR=XR*1.5; YR=YR*1.5;               % Convert & adjust the measurement from pixle to mm
XR=int32(XR); YR=int32(YR);                         % Convert X & Y value into integer
<<<<<<< Updated upstream
% texboxStatus = sprintf('X = %d  Y = %d', XR, YR);   % Set data to be showed
% set(handles.C_Coordinate,'String',texboxStatus);    % Show value into textbox
% sender('0');                                        % Call sender function to send '0' as linear mode
% pause(0.01);
% data=sprintf('[%d,%d,150]',XR, YR);                 % Set data to be sended 
% sender(data);                                       % Call sender function to send data
% set ( handles.CmdStatus, 'String' ,...              % Show command in the command status
%     ['Move End Efector Robot Linear to ' ] );
=======
texboxStatus = sprintf('X = %d  Y = %d', XR, YR);   % Set data to be showed
set(handles.C_Coordinate,'String',texboxStatus);    % Show value into textbox
>>>>>>> Stashed changes

inside = 0;
siz = size(handles.b);
for choco = 1:siz(1,1);
    for reg = 1:4 
        inside = inpolygon( X,Y,...
            handles.box{choco}.rec{reg}(1,:),...
            handles.box{choco}.rec{reg}(2,:));
        if inside ~= 0
            set(handles.editCommand,'string',...
                ['Yea Baby! it is inside '   num2str(choco) ] );
            boxID = choco;
            handles.bSelect = [boxID , reg];
            
            tempStr = data2str(handles.box{boxID}.xy,reg,0);
            set(handles.uitableRegion, 'data', tempStr);
            
            tempStr = data2str(handles.b(:,3),boxID,0);
            set(handles.uitableBox, 'data', tempStr);
            
             %plotting the rectangle 
            axes(handles.axesConvSelect);
            plot(handles.box{boxID}.rec{reg}(1,:),...
                handles.box{boxID}.rec{reg}(2,:), '--k');
            set(handles.axesConvSelect,'color','none','Xlim'...
                ,[0 640],'ylim',[0 480]...
                  ,'Xtick',[], 'Ytick',[]);
            guidata(hObject, handles);
            
            % Set the Currently Selected coordinate 
            X = handles.box{boxID}.xy(reg,1);
            Y = handles.box{boxID}.xy(reg,2);
            theta = handles.b(boxID,3);
            set(handles.textCurrentSelect, 'string' , num2str([X Y theta]) );
            return;
        end
    end
end

set(handles.uitableRegion, 'data', []);

tempStr = data2str(handles.b(:,3),0,0);
set(handles.uitableBox, 'data', tempStr);

set(handles.editCommand,'string','Not In Any Box' );

axes(handles.axesConvSelect);cla;
set(handles.axesConvSelect,'color','none','Xlim'...
    ,[0 640],'ylim',[0 480]...
      ,'Xtick',[], 'Ytick',[]);

% Set the Currently Selected coordinate . theta is left to be 0 for now  
set(handles.textCurrentSelect, 'string' , num2str([X Y 0]) );
  
guidata(hObject, handles);


% Executed when Click & GO button on Table camera pressed 
function Get_T_Coordinate_Callback(hObject, eventdata, handles)
[xx, yy]=ginput(1);

switch get(get(handles.singleSelection,'SelectedObject'),'Tag')
    case 'pickMode',  
        Data = handles.chocolates;
        dataSize = size(Data);
        selectedData = [];
        Row = [];
        for i=1:dataSize(1),
            in = checkPoint(xx , yy , Data(i,1) , Data(i,2),  -Data(i,3));
            if in == 1,
                selectedData = Data(i,:);
                Row = [Row,i];
            end
        end;
        axes(handles.axesTableSelect); cla; 
        set(handles.axesTableSelect,'color','none');
        try
            plotRectangle(selectedData(1,1) , selectedData(1,2),  -selectedData(1,3))
            handles.chocolatesStr =reshape(strtrim(cellstr(num2str(handles.chocolates(:)))),...
                size(handles.chocolates));
            handles.chocolatesStr(Row,:) = strcat('<html><body bgcolor="#0000FF" text="#FFFFFF" width="100px">', ...
                    handles.chocolatesStr(Row,:),'</span></html>');
            set(handles.ChocTable,'Data',handles.chocolatesStr);
    
            [Xr , Yr] = table2robot(selectedData(1,1),selectedData(1,2));
            newPickTarget = [double(Xr) , double(Yr) , handles.zTable , ...
                selectedData(1,3)];
            handles.pickTarget = [handles.pickTarget ; newPickTarget];
            set(handles.pickTargetList,'Data',handles.pickTarget);
            set(handles.nPickTargetShow,'string',...
                num2str(length(handles.pickTarget(:,1))));
        catch
            errordlg('No chocolate detected on that particular area');
        end
    case 'placeMode',
        [Xr, Yr] = table2robot(xx,yy);
        theta = get(handles.placeTargetTheta,'Value');
        theta = theta*pi/180;
        newPlaceTarget = [double(Xr) , double(Yr) , handles.zTable , ...
                theta];
        newPlaceTable = [xx , yy , theta] ;
        
        if ~isempty(handles.placeTarget(:,:))        
            len = length( find((handles.placeTarget(:,1)>newPlaceTarget(1,1)-10) && ...
                    (handles.placeTarget(:,1)<newPlaceTarget(1,1)+10)) && ...
                    (handles.placeTarget(:,2)>newPlaceTarget(1,2)-10) && ...
                    (handles.placeTarget(:,2)<newPlaceTarget(1,2)+10) );    

            handles.zTable= handles.zTable+ 6*(len);
        end
        
        handles.placeTable = [handles.placeTable ; newPlaceTable];
        handles.placeTarget = [handles.placeTarget ; newPlaceTarget];
        set(handles.placeTargetList,'Data',handles.placeTarget);
        set(handles.nPlaceTargetShow,'string',...
                num2str(length(handles.placeTarget(:,1))));
        axes(handles.placeTargetAxes); hold on;
        set(handles.placeTargetAxes,'color','none');
        plotTarget(handles.placeTable); hold off;
end
guidata(hObject, handles);


%% ------------------Activate Video Input----------------------------------
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
else                            % When it already connected      
    stop(handles.vid1);         % stop video 2 to disconnect from table camera
    stop(handles.vid2);         % stop video 2 to disconnect from conveyor camera
    delete(handles.vid1);         % stop video 2 to disconnect from table camera
    delete(handles.vid2);
    handles.Connect = 0;        % make the connection status = 0 ---> unconnected
    set(handles.connectButton,'String', 'Connect'); % Turn the button into connect button
end
guidata(hObject, handles);
%% ------------------------------------------------------------------------


%------------------------TIMER FUNCTION------------------------------------
%% ------------Maintain Connectivity with Robot Studio---------------------
function UpdateConnection(hObject,eventdata,hfigure,handles)
try
    handles.robotStatus = robBIND;
catch
    errordlgerrordlgerrordlg
end
guidata(hObject, handles);
%% ------------------------------------------------------------------------

%% ------------Maintain Chocolate Detection---------------------
function UpdateChocolate(hObject,eventdata,hfigure,handles)

<<<<<<< Updated upstream

function DetectChocolates(hObject,eventdata,hfigure,handles)
                  
drawnow();  % Push matlab to show the result before executing another function
%guidata(hObject, handles);


%--------------------------------------------------------------------------
% Managing Close GUI
%--------------------------------------------------------------------------
% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
disp('------------END OF RUN------------');
delete(hObject);
try
    delete(handles.vid1);   % Delete object input vodeo 1 before closing the GUI
    delete(handles.vid2);   % Delete object input vodeo 2 before closing the GUI
catch
end
delete(handles.timer1);  % Delete object timer before closing the GUI
delete(handles.timer);  % Delete object timer before closing the GUI
=======
%guidata(handles);
%% ------------------------------------------------------------------------
>>>>>>> Stashed changes

function showImage(hObject,handles)

    [imHeight,imWidth, nBands] = SetImage(handles.vid1,handles.vid1);
    axes(handles.TableCam);                              % set axes ConvCam for showing video 1
    hImage1 = image(zeros(imHeight(1),imWidth(1), nBands(1)), ... % set image frame as a the size of video image as a base for showing 
        'parent', handles.TableCam);                     % video image
    preview(handles.vid1,hImage1);                       % show video image 1 on hImage frame
    
    axes(handles.axesConvCam);                             % set axes TableCam for showing video 2
    hImage2 = image(zeros(imHeight(2), imWidth(2), nBands(2)), ... % set image frame as a the size of video image as a base for showing 
        'parent', handles.axesConvCam);                    % video image
    preview(handles.vid2,hImage2); 
    
    guidata(hObject, handles);


% --- Executes when selected cell(s) is changed in ChocTable1.
function ChocTable1_CellSelectionCallback(hObject, eventdata, handles)
handles.selectedRow = eventdata.Indices(1);
Data = get(handles.ChocTable1,'Data');
selectedData = Data(handles.selectedRow,:);
set(handles.selectedChocolateTable,'Data',selectedData);
axes(handles.axes3); cla;
plotRectangle(selectedData(1,1) , selectedData(1,2),  -selectedData(1,3))
disp(eventdata);
guidata(hObject, handles);


% --- Executes on button press in pushbutton36.
function pushbutton36_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in selectGroupButton.
function selectGroupButton_Callback(hObject, eventdata, handles)
Data = get(handles.ChocTable1,'Data');
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
<<<<<<< Updated upstream
try 
    imgTable=getsnapshot(handles.vid1);     % capture image from video 1 (Table camera)
    set(handles.editCommand, 'string', 'Snaphot from Table Camera');
catch
    imgTable=imread('IMG_013.jpg');
    set(handles.editCommand, 'string', 'Saved Image');
end
=======
%imgTable=getsnapshot(handles.vid1);     % capture image from video 1 (Table camera)
imgTable=imread('IMG_013.jpg');
>>>>>>> Stashed changes
axes(handles.TableCam);
image(imgTable);
set(handles.TableCam,'xtick',[],'ytick',[]);       % Supress the axes3 axis value

axes(handles.axes3);cla;
set(handles.axes3,'color','none');
c = findChoc((imgTable));   % HERE THE CHOC DETECTION
set(handles.axes3,'xtick',[],'ytick',[]);       % Supress the axes3 axis value

handles.chocolates =c(:,[1:3 6 8]);
handles.chocolatesStr =reshape(strtrim(cellstr(num2str(handles.chocolates(:)))),...
        size(handles.chocolates));
set(handles.ChocTable,'Data',handles.chocolatesStr); % show data chocolate on the table 
<<<<<<< Updated upstream
% set(handles.editCommand,'string','Done Detection');
guidata(hObject, handles);
=======
set(handles.editCommand,'string','Done Detection');


>>>>>>> Stashed changes

% --- Executes on button press in runButton.
function runButton_Callback(hObject, eventdata, handles)
pickTarget = get(handles.pickTargetList,'Data');
placeTarget = get(handles.placeTargetList,'Data');
Torobot(pickTarget(1),pickTarget(2),pickTarget(3),0,0,pickTarget(4));

function editCommand_Callback(hObject, eventdata, ~)
% Hints: get(hObject,'String') returns contents of editCommand as text
%        str2double(get(hObject,'String')) returns contents of editCommand as a double

% --- Executes during object creation, after setting all properties.
function editCommand_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonDetectBox.
function pushbuttonDetectBox_Callback(hObject, eventdata, handles)
%imgConv=getsnapshot(handles.vid2);      % capture image from video 2 (conveyor camera)
imgConv=imread('converyor4.jpg');
axes(handles.axesConvCam);
image(imgConv);
set(handles.axesConvCam,'xtick',[],'ytick',[]);

axes(handles.axesConvDetect);hold on;
[handles.b ,handles.box]=plotBoxConv(imgConv); hold off; % detect box

set(handles.axesConvDetect,'color','none'); 
set(handles.axesConvDetect,'xtick',[],'ytick',[]);

set(handles.uitableBox, 'data', handles.b(:,3));

set(handles.editCommand, 'String', 'Done Boxes Detection');
guidata(hObject, handles);


% --- Executes when selected cell(s) is changed in uitableBox.
function uitableBox_CellSelectionCallback(hObject, eventdata, handles)
try
    rowS = eventdata.Indices(1);
    set(handles.editCommand,'string',['Box ' num2str(rowS) ' was picked'] );

    set(handles.uitableBox, 'data', data2str(handles.b(:,3),rowS,0));

    set(handles.uitableRegion, 'data', data2str(handles.box{rowS}.xy,0,0));
    handles.bSelect(1,1) = rowS ;
catch
end

guidata(hObject, handles);


% --- Executes when selected cell(s) is changed in uitableRegion.
function uitableRegion_CellSelectionCallback(hObject, eventdata, handles)
try    
    boxID = handles.bSelect(1,1);
    rowS = eventdata.Indices(1);
    set(handles.editCommand,'string',['Region '...
        num2str(rowS) ' of box ' num2str(boxID) ' was picked'] );
    
    tempStr = data2str(handles.box{boxID}.xy, rowS,0 );    
    
    set(handles.uitableRegion, 'data', tempStr);
    handles.bSelect(1,2) = rowS ;
    
    axes(handles.axesConvSelect);
    plot(handles.box{boxID}.rec{rowS}(1,:),...
        handles.box{boxID}.rec{rowS}(2,:), '--k');
    set(handles.axesConvSelect, 'Xlim', [0,640], 'YLim', [0 480]...
        ,'color','none' ,'xtick',[],'ytick',[]);
    
    % Set the current coordinate textbox
    X = handles.box{boxID}.xy(rowS,1);
    Y = handles.box{boxID}.xy(rowS,2);
    theta = handles.b(rowS,3);
    set(handles.textCurrentSelect, 'string' , num2str([X Y theta]) );

    
catch
end


guidata(hObject, handles);

% --- Executes on key release with focus on figure1 and none of its controls.
function figure1_KeyReleaseFcn(hObject, eventdata, handles)
k=get(gcf,'CurrentCharacter');
disp(k);
if k =='q'
    close all;clc;clear;
end
if k =='/'
    uwait(errordlg('I LOVE CHOCOLATES', 'I LOVE CHOCOLATES'));
end

% --- Executes when selected cell(s) is changed in ChocTable.
function ChocTable_CellSelectionCallback(hObject, eventdata, handles)
try
handles.selectedRow = eventdata.Indices(1);
handles.selectedChocolate = handles.chocolates(handles.selectedRow,:);
handles.chocolatesStr =reshape(strtrim(cellstr(num2str(handles.chocolates(:)))),...
        size(handles.chocolates));
handles.chocolatesStr(handles.selectedRow,:) = strcat('<html><body bgcolor="#0000FF" text="#FFFFFF" width="100px">', ...
            handles.chocolatesStr(handles.selectedRow,:),'</span></html>');
set(handles.ChocTable,'Data',handles.chocolatesStr);
axes(handles.axesTableSelect); cla;
set(handles.axesTableSelect,'color','none');
plotRectangle(handles.selectedChocolate(1,1) , ...
    handles.selectedChocolate(1,2),  -handles.selectedChocolate(1,3));
catch
end
guidata(hObject, handles);

% --- Executes on button press in selectMilk.
function selectMilk_Callback(hObject, eventdata, handles)
% Hint: get(hObject,'Value') returns toggle state of selectMilk

% --- Executes on button press in selectDark.
function selectDark_Callback(hObject, eventdata, handles)
% Hint: get(hObject,'Value') returns toggle state of selectDark

% --- Executes on button press in selectMint.
function selectMint_Callback(hObject, eventdata, handles)
% Hint: get(hObject,'Value') returns toggle state of selectMint

% --- Executes on button press in selectOrange.
function selectOrange_Callback(hObject, eventdata, handles)
% Hint: get(hObject,'Value') returns toggle state of selectOrange

% --- Executes on button press in selectBack.
function selectBack_Callback(hObject, eventdata, handles)
% Hint: get(hObject,'Value') returns toggle state of selectBack

function nBackInput_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function nBackInput_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function nMintInput_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function nMintInput_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function nMilkInput_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function nMilkInput_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function nDarkInput_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function nDarkInput_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function nOrangeInput_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function nOrangeInput_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pushbutton41.
function pushbutton41_Callback(hObject, eventdata, handles)

try
Data = handles.chocolates;
flavourColoum = Data(:,4);
selectedData = [];
if get(handles.selectMilk,'value')==1,
    Nstr = get(handles.nMilkInput,'string');
    if strcmp(Nstr,'all')==1,
        milkRow = find(flavourColoum==1);
        selectedData = [selectedData ; Data(milkRow,:)];
    else
        N = uint16(str2double(Nstr));
        milkRow = find(flavourColoum==1);
        selectedData = [selectedData ; Data(milkRow(1:N),:)];
    end
end

if get(handles.selectDark,'value')==1,
    Nstr = get(handles.nDarkInput,'string');
    darkRow = find(flavourColoum==2);
    if strcmp(Nstr,'all')==1,
        selectedData = [selectedData ; Data(darkRow,:)];
    else
        N = uint16(str2double(Nstr));
        selectedData = [selectedData ; Data(darkRow(1:N),:)];
    end
end
if get(handles.selectOrange,'value')==1,
    Nstr = get(handles.nOrangeInput,'string');
    orangeRow = find(flavourColoum==3);
    if strcmp(Nstr,'all')==1,
        selectedData = [selectedData ; Data(orangeRow,:)];
    else
        N = uint16(str2double(Nstr));
        selectedData = [selectedData ; Data(orangeRow(1:N),:)];
    end
end
if get(handles.selectMint,'value')==1,
    Nstr = get(handles.nMintInput,'string');
    mintRow = find(flavourColoum==4);
    if strcmp(Nstr,'all')==1,
        selectedData = [selectedData ; Data(mintRow,:)];
    else
        N = uint16(str2double(Nstr));
        selectedData = [selectedData ; Data(mintRow(1:N),:)];
    end
end
if get(handles.selectBack,'value')==1,
    Nstr = get(handles.nBackInput,'string');
    backRow = find(flavourColoum==0);
    if strcmp(Nstr,'all')==1,
        selectedData = [selectedData ; Data(backRow,:)];
    else
        N = uint16(str2double(Nstr));
        selectedData = [selectedData ; Data(backRow(1:N),:)];
    end
end

axes(handles.axesTableSelect); cla; 
for i=1:length(selectedData(:,1)),
    [Xr , Yr] = table2robot(selectedData(i,1),selectedData(i,2));
    newPickTarget = [double(Xr) , double(Yr) , handles.zTable , ...
                selectedData(i,3)];
    handles.pickTarget = [handles.pickTarget ; newPickTarget];
    set(handles.pickTargetList,'Data',handles.pickTarget);
    set(handles.nPickTargetShow,'string',...
         num2str(length(handles.pickTarget(:,1))));
    hold on; 
    set(handles.axesTableSelect,'color','none');
    plotRectangle(selectedData(i,1) , selectedData(i,2),  -selectedData(i,3));
    hold off;
end
catch
    errordlg('Not Enough Chocolates');
end
guidata(hObject, handles);

% --- Executes on button press in pushbutton44.
function pushbutton44_Callback(hObject, eventdata, handles)
[Xr , Yr] = table2robot(handles.selectedChocolate(1),handles.selectedChocolate(2));
newPickTarget = [double(Xr) , double(Yr) , handles.zTable , ...
    handles.selectedChocolate(3)];
handles.pickTarget = [handles.pickTarget ; newPickTarget];
set(handles.pickTargetList,'Data',handles.pickTarget);
set(handles.nPickTargetShow,'string',num2str(length(handles.pickTarget(:,1))));
guidata(hObject, handles);

% --- Executes on slider movement.
function placeTargetTheta_Callback(hObject, eventdata, handles)
newTheta = get(hObject,'Value');
newTheta = newTheta*pi/180;
handles.placeTarget(handles.selectedPlace,4) = newTheta;
set(handles.placeTargetList,'Data',handles.placeTarget);
handles.placeTable(handles.selectedPlace,3)=newTheta;
axes(handles.placeTargetAxes); cla; hold on;
set(handles.placeTargetAxes,'color','none');
plotTarget(handles.placeTable); hold off;        
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function placeTargetTheta_CreateFcn(hObject, eventdata, handles)
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on button press in pushbutton45.
function pushbutton45_Callback(hObject, eventdata, handles)
handles.pickTarget=[];
set(handles.pickTargetList,'Data',handles.pickTarget);
set(handles.nPickTargetShow,'string','0');
guidata(hObject, handles);

% --- Executes on button press in pushbutton46.
function pushbutton46_Callback(hObject, eventdata, handles)
handles.placeTarget=[];
handles.placeTable = [];
set(handles.placeTargetList,'Data',handles.placeTarget);
set(handles.nPlaceTargetShow,'string','0');
axes(handles.placeTargetAxes); cla;
guidata(hObject, handles);

% --- Executes when selected cell(s) is changed in placeTargetList.
function placeTargetList_CellSelectionCallback(hObject, eventdata, handles)
handles.selectedPlace = eventdata.Indices(1);
guidata(hObject, handles);

<<<<<<< Updated upstream

=======
>>>>>>> Stashed changes
% --- Executes on button press in pushbutton48.
function pushbutton48_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton48 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

<<<<<<< Updated upstream

=======
>>>>>>> Stashed changes
% --- Executes on button press in pushbutton49.
function pushbutton49_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton49 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

<<<<<<< Updated upstream

% --- Executes on button press in pushbuttonSetPICK.
function pushbuttonSetPICK_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonSetPICK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbuttonSetPLACE.
function pushbuttonSetPLACE_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonSetPLACE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
=======
function figure1_WindowKeyPressFcn(hObject, eventdata, handles)

function figure1_WindowKeyReleaseFcn(hObject, eventdata, handles)

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
stop(handles.chocolateTimer)
delete(handles.chocolateTimer)


function DetectChocolates(hObject,eventdata,hfigure,handles)
                  
drawnow();  % Push matlab to show the result before executing another function
%guidata(hObject, handles);

%--------------------------------------------------------------------------
% Managing Axis
%--------------------------------------------------------------------------
function axesConvCam_CreateFcn(hObject, eventdata, handles)
% Hint: place code in OpeningFc
% --- Executes during object creation, after setting all properties.

%------------------- Managing Table Object---------------------------------
% Creating table object to show the list of detected chocolate
function ChocTable1_CreateFcn(hObject, eventdata, handles)
>>>>>>> Stashed changes
