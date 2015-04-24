% CHECKLIST GUI
% List the prerequisites before running the robot.
%   All checkbox need to be clicked first before the push button can be
%   clicked, closing the checklist window while opening the GUI to control
%   the robot.
%   Is the m file that need to be run first,

% Begin initialization code - DO NOT EDIT
function varargout = CheckList_GUI(varargin)


gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CheckList_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @CheckList_GUI_OutputFcn, ...
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


% --- Executes just before CheckList_GUI is made visible.
function CheckList_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
handles.c=0;
guidata(hObject, handles);



function varargout = CheckList_GUI_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


function checkbox1_Callback(hObject, eventdata, handles)
function checkbox2_Callback(hObject, eventdata, handles)
function checkbox3_Callback(hObject, eventdata, handles)
function checkbox4_Callback(hObject, eventdata, handles)
function checkbox5_Callback(hObject, eventdata, handles)
function checkbox6_Callback(hObject, eventdata, handles)
%---------------------------


function pushbutton2_Callback(hObject, eventdata, handles)
% check if all every checkbox was clicked
if ((get(handles.checkbox1,'value'))+...    
        (get(handles.checkbox2,'value'))+...
        (get(handles.checkbox3,'value'))+...
        (get(handles.checkbox4,'value'))+...
        (get(handles.checkbox5,'value'))+...
        (get(handles.checkbox6,'value')))==6,
    
    % Run the new GUI and close the current checklist window.
    run GUI_Design_2015_04_8
    close CheckList_GUI
end


