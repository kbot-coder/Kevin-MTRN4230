function varargout = GUIchocDetect(varargin)
% GUICHOCDETECT MATLAB code for GUIchocDetect.fig
%      GUICHOCDETECT, by itself, creates a new GUICHOCDETECT or raises the existing
%      singleton*.
%
%      H = GUICHOCDETECT returns the handle to a new GUICHOCDETECT or the handle to
%      the existing singleton*.
%
%      GUICHOCDETECT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUICHOCDETECT.M with the given input arguments.
%
%      GUICHOCDETECT('Property','Value',...) creates a new GUICHOCDETECT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUIchocDetect_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUIchocDetect_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUIchocDetect

% Last Modified by GUIDE v2.5 30-Apr-2015 02:10:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUIchocDetect_OpeningFcn, ...
                   'gui_OutputFcn',  @GUIchocDetect_OutputFcn, ...
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


% --- Executes just before GUIchocDetect is made visible.
function GUIchocDetect_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUIchocDetect (see VARARGIN)

% Choose default command line output for GUIchocDetect
handles.output = hObject;
handles.chocStat = [];
handles.chocRec = [];
handles.chocPicked = 0;
handles.chocString = {};



% Show what need to need to be done before start
axes(handles.axesVid);
chocImage = imread('Training set/IMG_005.jpg');
imshow(chocImage);

set(handles.edit1,'string', 'YES MASTER,  what should I do? ' );


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUIchocDetect wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUIchocDetect_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)

    set(handles.edit1,'string', 'detection in progress');
    chocImage = imread('Training set/IMG_005.jpg');
    % Show Video Preview
    
%     chocImage = imread('all.png');
    

    % Plot the Detected Perimeters
    axes(handles.axesDetect);
    handles.chocStat    = [];
    [handles.chocStat ,handles.chocRec ]  = findChoc(chocImage);
    set(handles.axesDetect,'color','none','Xlim',[0 1600],'ylim',[0 900]...
        ,'Xtick',[], 'Ytick',[]);
    
    
    set(handles.edit1,'string', 'done detection');
    
    handles.chocString = data2str(handles.chocStat,0,0);
    set(handles.uitable1, 'data', handles.chocString );
    
    
    guidata(hObject, handles);



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected cell(s) is changed in uitable1.
function uitable1_CellSelectionCallback(hObject, eventdata, handles)
try
    chocN = eventdata.Indices(1);
    set(handles.edit1,'string', ['Master picked chocolate ' num2str(chocN)] );
    handles.chocPicked = chocN;

    set(handles.uitable1, 'data', handles.chocString);

    tempStr = data2str(handles.chocString,chocN,'string');

    %# set table data
    set(handles.uitable1, 'data', tempStr);



    %plotting the rectangle 
    axes(handles.axesSelect);
    plot(handles.chocRec{chocN}(1,:), handles.chocRec{chocN}(2,:), '--k'); 
    set(handles.axesSelect,'color','none','Xlim',[0 1600],'ylim',[0 900]...
          ,'Xtick',[], 'Ytick',[]);
catch
end
 guidata(hObject, handles);


% --- Executes on button press in ChooseChocBtn.
function ChooseChocBtn_Callback(hObject, eventdata, handles)
set(handles.edit1,'string', 'Press ENTER to cancel' );
[X, Y]=ginput(1); 
set(handles.edit1,'string', ['X : ' num2str(X) ...
    '     Y : ' num2str(Y) ] );
inside = 0;
for choco = 1:60
    try
        inside = inpolygon( X,Y,...
            handles.chocRec{choco}(1,:), handles.chocRec{choco}(2,:));
        if inside ~= 0
            set(handles.edit1,'string',...
                ['Yea Baby! it is inside '   num2str(choco) ] );
            chocN = choco;
            handles.chocPicked = chocN;

            set(handles.uitable1, 'data', handles.chocString);

            tempStr = data2str(handles.chocString,chocN,'string');

            %# set table data
            set(handles.uitable1, 'data', tempStr);

            %plotting the rectangle 
            axes(handles.axesSelect);
            plot(handles.chocRec{chocN}(1,:), ...
               handles.chocRec{chocN}(2,:), '--k'); 
            set(handles.axesSelect,'color','none','Xlim'...
                ,[0 1600],'ylim',[0 900]...
                  ,'Xtick',[], 'Ytick',[]);
                
            guidata(hObject, handles);
            return;
        end
    catch
    end      
end
set(handles.edit1,'string', 'It is not in.. Yet '  );
set(handles.uitable1, 'data', handles.chocString);
guidata(hObject, handles);

