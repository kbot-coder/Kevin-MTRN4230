function varargout = OrderGui(varargin)
% ORDERGUI MATLAB code for OrderGui.fig
%      ORDERGUI, by itself, creates a new ORDERGUI or raises the existing
%      singleton*.
%
%      H = ORDERGUI returns the handle to a new ORDERGUI or the handle to
%      the existing singleton*.
%
%      ORDERGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ORDERGUI.M with the given input arguments.
%
%      ORDERGUI('Property','Value',...) creates a new ORDERGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before OrderGui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to OrderGui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help OrderGui

% Last Modified by GUIDE v2.5 01-Jun-2015 01:51:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @OrderGui_OpeningFcn, ...
                   'gui_OutputFcn',  @OrderGui_OutputFcn, ...
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


% -=============Executes just before OrderGui is made visible.=============
function OrderGui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to OrderGui (see VARARGIN)

global order orderCustom avail REALPOS

REALPOS = [200, 100; 200, 200; 200, 300; 200, 400];
order       = [0,0,0,0];
avail   = [0,0,0,0];
orderCustom = [];

% Choose default command line output for OrderGui
handles.output = hObject;
oneCl = 'To cancel:' ;
twoCl ='<Ctrl+C> then <sender(''S2'')> in command windows';
clc;
disp('------------   START   -----------');

% Initialising Timers 
handles.timerRoBIND = timer(... 
    'ExecutionMode', 'fixedRate', ...               
    'Period', 7, ...                              
    'TimerFcn', {@tmrRoBIND,hObject,handles});

handles.timerOrder = timer(...
    'ExecutionMode', 'fixedRate', ...               
    'Period',  0.5, ...                              
    'TimerFcn', {@tmrOrder,hObject,handles});

handles.timerCustomOrder = timer(...
    'ExecutionMode', 'fixedRate', ...               
    'Period', 0.5, ...                              
    'TimerFcn', {@tmrCustomOrder,hObject,handles});

% ----------------------Warming up Processes-------------------------

% Check connection-----
while(1)
    disp('Checking connection');
    switch robBIND
        case 'RED'
            uiwait(msgbox('No connnection. Reconnect then <OK>',...
                'Warm','modal'));
        case 'YELLOW'
            uiwait(msgbox('Robot Busy. Finish current task,then <OK>',...
                'Warm','modal'));
        case 'GREEN'
            break;       
    end
end

% connect to camera : vid1=table, vid2=conveyor-----
[handles.vid1,handles.vid2,videoConnect] = ConnectToCameraAuto;%Managing Video handles  
disp('Warming up......');disp('Please wait');

% move the box away of the camera---------
msgbox({'Move the box away of the camera. ' oneCl twoCl } ,'Warm','modal');
TOio(0,0,1,0,300);
pause(3);
TOio(0,0,0,0,300);
pause(1);

% clearing pre stacking area-----
msgbox({'Clearing the pre-stacking area. ' oneCl twoCl } ,'Warm','modal');
clear_table;

% stacking known chocolates -----
msgbox({'Stacking chocolates on the table' oneCl twoCl },'Warm','modal');
while 1
    if strcmp(TOrobot(0,-409,200,0,0,0),'DONE')
        waiting;
        try 
            imgTable=getsnapshot(handles.vid1); 
        catch
            imgTable=imread('IMG_011.jpg');fromImage=1;
        end
        % x y thta sz sz flav top rch pck            
        [c]= detect_chocolates_clearhome_onechoc(imgTable);
        if isempty(c)||c(1,6)==0
            break;
        else
            [X,Y] = table2robot(c(1,1),c(1,2));
            moveDownUp(X,Y,200,c(1,3),1,47);
            switch c(1,6)
                case 1
                    moveDownUp(200,-400,200,0,0,47-avail(1,1)*6.4);
                    avail(1,1) = avail(1,1)+1;
                case 2
                    moveDownUp(200,-300,200,0,0,47-avail(1,2)*6.4);
                    avail(1,2) = avail(1,2)+1;
                case 3
                    moveDownUp(200,-200,200,0,0,47-avail(1,3)*6.4);
                    avail(1,3) = avail(1,3)+1;
                case 4
                    moveDownUp(200,-100,200,0,0,47-avail(1,4)*6.4);
                    avail(1,4) = avail(1,4)+1;
            end
        end
    end
    if fromImage
        break
    end
end

% flipping unknown-----
msgbox({'Flipping the unknown chocolates' oneCl twoCl },'Warm','modal');
while 1
    if strcmp(TOrobot(0,409,200,0,0,0),'DONE')
        waiting;
        try 
            imgTable = getsnapshot(handles.vid1); 
        catch
            imgTable = imread('IMG_011.jpg');fromImage=1;
        end
        % x y thta sz sz flav top rch pck            
        [cT]= detect_chocolates_clearhome_onechoc(imgTable);
        if cT(1,6)~=0 || isempty(cT)
            break;
        else
            [Xf,Yf] = table2robot(cT(1,1),cT(1,2));
            while 1
                flip_choc_to_conv(Xf, Yf, cT(1,3));
                TOio(0,0,1,0,300);
                pause(1);
                TOio(0,0,0,0,300);
                pause(0.5);
                try
                    imgConv = getsnapshot(handles.vid2);
                catch
                    imgConv = imread('IMG_011.jpg');fromImage=1;
                end
                cC = detect_chocolates_conv(imgConv);
                [Xc,Yc] = conveyor2robot(cC(1,1),cC(1,2));
                if cV(1,6)~=0
                    moveDownUp(Xc,Yc,200,cV(1,3)+90,1,172);
                    switch cV(1,6)
                        case 1
                            moveDownUp(200,-400,200,0,0,47-avail(1,1)*6.4);
                            avail(1,1) = avail(1,1)+1;
                        case 2
                            moveDownUp(200,-300,200,0,0,47-avail(1,2)*6.4);
                            avail(1,2) = avail(1,2)+1;
                        case 3
                            moveDownUp(200,-200,200,0,0,47-avail(1,3)*6.4);
                            avail(1,3) = avail(1,3)+1;
                        case 4
                            moveDownUp(200,-100,200,0,0,47-avail(1,4)*6.4);
                            avail(1,4) = avail(1,4)+1;
                    end
                    break
                elseif isempty(cV)
                    break
                end
                TOio(0,0,1,1,300);
                pause(1);
                TOio(0,0,0,1,300);
                pause(0.5);
            end
        end
    end
end

% move the box back in to the camera view---------
msgbox({'Move the box back into the camera view. ' oneCl twoCl } ,'Warm','modal');
TOio(0,0,1,1,300);
pause(3);
TOio(0,0,0,0,300);
pause(1);

% unload onto table-----
msgbox({'Unloading the box onto the table' oneCl twoCl },'Warm','modal');
try
    imgConv=getsnapshot(handles.vid2);
catch
    imgConv=imread('converyor40.jpg');
end
[~,box] = NoPlotBoxConv(imgConv);

placement = 0;
for layer =1:3
    for region=1:4
        [Xr,Yr] = conveyor2robot(box{1}.xy(region,1),box{1}.xy(region,2));
        moveDownUp(Xr,Yr,200,box{1}.theta+90 ,1,153.5+6.4*layer);
        #######Put the choc to the locations    
    end
end

% stacking known chocolates 22222-----
msgbox({'Stacking chocolates on the table_2' oneCl twoCl },'Warm','modal');
while 1
    if strcmp(TOrobot(0,-409,200,0,0,0),'DONE')
        waiting;
        try 
            imgTable=getsnapshot(handles.vid1); 
        catch
            imgTable=imread('IMG_011.jpg');fromImage=1;
        end
        % x y thta sz sz flav top rch pck            
        [c]= detect_chocolates_clearhome_onechoc(imgTable);
        if isempty(c)||c(1,6)==0
            break;
        else
            [X,Y] = table2robot(c(1,1),c(1,2));
            moveDownUp(X,Y,200,c(1,3),1,47);
            switch c(1,6)
                case 1
                    moveDownUp(200,-400,200,0,0,47-avail(1,1)*6.4);
                    avail(1,1) = avail(1,1)+1;
                case 2
                    moveDownUp(200,-300,200,0,0,47-avail(1,2)*6.4);
                    avail(1,2) = avail(1,2)+1;
                case 3
                    moveDownUp(200,-200,200,0,0,47-avail(1,3)*6.4);
                    avail(1,3) = avail(1,3)+1;
                case 4
                    moveDownUp(200,-100,200,0,0,47-avail(1,4)*6.4);
                    avail(1,4) = avail(1,4)+1;
            end
        end
    end
    if fromImage
        break
    end
end
% flipping unknown 2222-----
msgbox({'Flipping the unknown chocolates_2' oneCl twoCl },'Warm','modal');
while 1
    if strcmp(TOrobot(0,409,200,0,0,0),'DONE')
        waiting;
        try 
            imgTable = getsnapshot(handles.vid1); 
        catch
            imgTable = imread('IMG_011.jpg');fromImage=1;
        end
        % x y thta sz sz flav top rch pck            
        [cT]= detect_chocolates_clearhome_onechoc(imgTable);
        if cT(1,6)~=0 || isempty(cT)
            break;
        else
            [Xf,Yf] = table2robot(cT(1,1),cT(1,2));
            while 1
                flip_choc_to_conv(Xf, Yf, cT(1,3));
                TOio(0,0,1,0,300);
                pause(1);
                TOio(0,0,0,0,300);
                pause(0.5);
                try
                    imgConv = getsnapshot(handles.vid2);
                catch
                    imgConv = imread('IMG_011.jpg');fromImage=1;
                end
                cC = detect_chocolates_conv(imgConv);
                [Xc,Yc] = conveyor2robot(cC(1,1),cC(1,2));
                if cV(1,6)~=0
                    moveDownUp(Xc,Yc,200,cV(1,3)+90,1,172);
                    switch cV(1,6)
                        case 1
                            moveDownUp(200,-400,200,0,0,47-avail(1,1)*6.4);
                            avail(1,1) = avail(1,1)+1;
                        case 2
                            moveDownUp(200,-300,200,0,0,47-avail(1,2)*6.4);
                            avail(1,2) = avail(1,2)+1;
                        case 3
                            moveDownUp(200,-200,200,0,0,47-avail(1,3)*6.4);
                            avail(1,3) = avail(1,3)+1;
                        case 4
                            moveDownUp(200,-100,200,0,0,47-avail(1,4)*6.4);
                            avail(1,4) = avail(1,4)+1;
                    end
                    break
                elseif isempty(cV)
                    break
                end
                TOio(0,0,1,1,300);
                pause(1);
                TOio(0,0,0,1,300);
                pause(0.5);
            end
        end
    end
end

% Reposition the stacking-----
msgbox({' Reposition the stacking area to the left ' oneCl twoCl },'Warm','modal');
fakePos = [200,-400; 200,-300; 200,-200; 200,-100;];
realPos = [200, 100; 200, 200; 200, 300; 200, 400;];
%[milk, dark, orange, mint]
for flvo = 4:-1:1
    for layer = (avail(1,flvo)):-1:1
        X = fakePos(flvo,1);Y = fakePos(flvo,2);
        moveDownUp(X,Y,200,0,1,53-layer*6.5);
        X = realPos(flvo,1);Y = realPos(flvo,2);
        moveDownUp(X,Y,200,0,0,200-(avail(1,flvo))*6.5+layer*6.5);
    end 
end

% -----------------------------------------------

delete(findobj(allchild(0), '-regexp', 'Tag', '^Msgbox_'));%close all msgbox
start(handles.timerRoBIND);       
guidata(hObject, handles);
% -========================================================================
% >=============Executes when user attempts to CLOSE=======================
function figure1_CloseRequestFcn(hObject, eventdata, handles)
disp('------------END OF RUN------------');
delete(hObject);
try
    delete(handles.vid1);   % Delete object input vodeo 1 before closing the GUI
    delete(handles.vid2);   % Delete object input vodeo 2 before closing the GUI
catch
end
delete(handles.timerOrder);
delete(handles.timerRoBIND);  
delete(handles.timerCustomOrder);
% <============================================CLOSE=======================

%------------------------TIMER FUNCTION------------------------------------
% This function will be executed every time timer object iterated
%--------------------------------------------------------------------------
function tmrRoBIND(hObject,eventdata,hfigure,handles)
robStat = robBIND;
set(handles.textConnection,'String',robStat);
switch robStat
    case 'RED'        
        disp('RED');
        uwait(errordlg('Please reconnect to robot studio','Connection Error'));
    case 'YELLOW'  
        disp('YELLOW');
    case 'GREEN' 
        disp('GREEN');
end
%#%
function tmrOrder(hObject,eventdata,hfigure,handles)
global order avail taskStep taskCur REALPOS
% REALPOS = [200, 100; 200, 200; 200, 300; 200, 400;];
%[milk, dark, orange, mint]
switch taskCur
    case 'goPick'
        for i = 1:4
            sumbodi=sum(order(1:i));
            if taskStep<=sumbodi
                X = REALPOS(i,1);Y = REALPOS(i,1);
                if strcmp(TOrobot(X,Y,200,0,0,0),'DONE')
                    taskCur = 'goPickCheck';
                    showCurrentTask(handles.listboxTasks,'~ Setting the pick');
                else
                    showCurrentTask(handles.listboxTasks,'~ Disconnected');
                    taskStep = 100;
                end
            end
        end
    case 'goPickCheck'
        switch  robSTAT
            case 'GREEN'
                showCurrentTask(handles.listboxTasks,'~ On top of pick');
                taskCur = 'goPickDown';
            case 'RED'
                showCurrentTask(handles.listboxTasks,'~ Disconnected');
                taskStep = 100;
            case 'YELLOW'
                showCurrentTask(handles.listboxTasks,'~ Moving to pick');
        end        
    case 'goPickDown'
        for i = 1:4
            sumbodi=sum(order(1:i));
            if taskStep<=sumbodi
                X = REALPOS(i,1);Y = REALPOS(i,1);
                if strcmp(TOrobot(X,Y,148+(sumbodi-taskStep)*6.5 ,0,0,0),'DONE');
                    taskCur = 'goPickDownCheck';
                    showCurrentTask(handles.listboxTasks,'~ Going down to pick');
                else
                    showCurrentTask(handles.listboxTasks,'~ Disconnected');
                    taskStep = 100;
                end
            end
        end
    case 'goPickDownCheck'
        switch  robSTAT
            case 'GREEN'
                showCurrentTask(handles.listboxTasks,'~ On top of chocolate');
                taskCur = 'onVacumm';
            case 'RED'
                showCurrentTask(handles.listboxTasks,'~ Disconnected');
                taskStep = 100;
            case 'YELLOW'
                showCurrentTask(handles.listboxTasks,'~ Going down to pick');
        end  
    case 'onVacumm'
        TOio(1,1,0,0,300);
        showCurrentTask(handles.listboxTasks,'~ Turning on Vacumm');
        pause(0.5);      
        taskCur = 'goPickUp';
    case 'goPickUp'
        for i = 1:4
            sumbodi=sum(order(1:i));
            if taskStep<=sumbodi
                X = REALPOS(i,1);Y = REALPOS(i,1);
                if strcmp(TOrobot(X,Y,200,0,0,0),'DONE');
                    taskCur = 'goPickUpCheck';
                    showCurrentTask(handles.listboxTasks,'~ Picking up a chocolate');
                else
                    showCurrentTask(handles.listboxTasks,'~ Disconnected');
                    taskStep = 100;
                end
            end
        end
    case 'goPickUpCheck'
        switch  robSTAT
            case 'GREEN'
                showCurrentTask(handles.listboxTasks,'~ Above the stack chocolate');
                taskCur = 'goPlace';
            case 'RED'
                showCurrentTask(handles.listboxTasks,'~ Disconnected');
                taskStep = 100;
            case 'YELLOW'
                showCurrentTask(handles.listboxTasks,'~ Picking up a chocolate');
        end  
        
    case 'goPlace'%%%
        try
            imgConv=getsnapshot(handles.vid2); 
        catch
            imgConv=imread('converyor40.jpg');
        end
        [~,box] = NoPlotBoxConv(imgConv);
        for i = 1:4
            sumbodi=sum(order(1:i));
            if taskStep<=sumbodi
                boxReg = rem(taskStep,4);
                if boxReg==0
                    boxReg = 4;
                end
                X = box{1}.xy(boxReg,1); Y = box{1}.xy(boxReg,2);
                [X,Y] = conveyor2robot(X,Y);
                if strcmp(TOrobot(X,Y,200,0,0,rad2deg(box{1}.theta)+90),'DONE');
                    taskCur = 'goPlaceCheck';
                    showCurrentTask(handles.listboxTasks,'~ Moving to place');
                else
                    showCurrentTask(handles.listboxTasks,'~ Disconnected');
                    taskStep = 100;
                end
            end
        end
    case 'goPlaceCheck'%%%
        switch  robSTAT
            case 'GREEN'
                showCurrentTask(handles.listboxTasks,'~ On top of place');
                taskCur = 'goPlaceDown';
            case 'RED'
                showCurrentTask(handles.listboxTasks,'~ Disconnected');
                taskStep = 100;
            case 'YELLOW'
                showCurrentTask(handles.listboxTasks,'~ Moving to place');
        end  
    case 'goPlaceDown'%%
        try
            imgConv=getsnapshot(handles.vid2); 
        catch
            imgConv=imread('converyor40.jpg');
        end
        [~,box] = NoPlotBoxConv(imgConv);
        for i = 1:4
            sumbodi=sum(order(1:i));
            if taskStep<=sumbodi
                boxReg = rem(taskStep,4);
                if boxReg==0
                    boxReg = 4;
                end
                X = box{1}.xy(boxReg,1); Y = box{1}.xy(boxReg,2);
                [X,Y] = conveyor2robot(X,Y);
                if strcmp(TOrobot(X,Y,22.1+6.5*(taskStep-sumbodi),0,0,rad2deg(box{1}.theta)+90),'DONE');
                    taskCur = 'goPlaceDownCheck';
                    showCurrentTask(handles.listboxTasks,'~ Going down');
                else
                    showCurrentTask(handles.listboxTasks,'~ Disconnected');
                    taskStep = 100;
                end
            end
        end
    case 'goPlaceDownCheck'%%%
        switch  robSTAT
            case 'GREEN'
                showCurrentTask(handles.listboxTasks,'~ On top of chocolate');
                taskCur = 'goPlaceDown';
            case 'RED'
                showCurrentTask(handles.listboxTasks,'~ Disconnected');
                taskStep = 100;
            case 'YELLOW'
                showCurrentTask(handles.listboxTasks,'~ Going down');
        end  
    case 'offVacumm'%%%
        TOio(0,0,0,0,300);
        showCurrentTask(handles.listboxTasks,'~ Turning on Vacumm');
        pause(0.5);      
        taskCur = 'goPlaceUp';
    case 'goPlaceUp'%%%  
        try
            imgConv=getsnapshot(handles.vid2); 
        catch
            imgConv=imread('converyor40.jpg');
        end
        [~,box] = NoPlotBoxConv(imgConv);
        for i = 1:4
            sumbodi=sum(order(1:i));
            if taskStep<=sumbodi
                boxReg = rem(taskStep,4);
                if boxReg==0
                    boxReg = 4;
                end
                X = box{1}.xy(boxReg,1); Y = box{1}.xy(boxReg,2);
                [X,Y] = conveyor2robot(X,Y);
                if strcmp(TOrobot(X,Y,200),0,0,rad2deg(box{1}.theta)+90),'DONE');
                    taskCur = 'goPlaceDownCheck';
                    showCurrentTask(handles.listboxTasks,'~ Going up');
                else
                    showCurrentTask(handles.listboxTasks,'~ Disconnected');
                    taskStep = 100;
                end
            end
        end        
    case 'goPlaceUpCheck'
        switch  robSTAT
            case 'GREEN'
                showCurrentTask(handles.listboxTasks,'~ Done a placement');
                taskCur = 'goPick';
            case 'RED'
                showCurrentTask(handles.listboxTasks,'~ Disconnected');
                taskStep = 100;
            case 'YELLOW'
        end  
        taskCur = 'goPick';
        taskStep = taskStep+1;             
end

if taskStep > sum(order)
    showCurrentTask(handles.listboxTasks,'~ Finished the order');
    taskStep =0;
    stop(handles.timerOrder);
    return;
end









function tmrCustomOrder(hObject,eventdata,hfigure,handles)
global orderCustom avail taskStep taskCur REALPOS
% REALPOS = [200, 100; 200, 200; 200, 300; 200, 400;];
%[milk, dark, orange, mint]

layer = rem(taskStep,3);
if layer==0
    layer=3;
end
for i = 1:4
    if sum(orderCustom(1:i))<
        
    end
end

switch taskCur
    case 'goPick'
        for i = 1:4
            sumbodi=sum(order(1:i));
            if taskStep<=sumbodi
                X = REALPOS(i,1);Y = REALPOS(i,1);
                if strcmp(TOrobot(X,Y,200,0,0,0),'DONE')
                    taskCur = 'goPickCheck';
                    showCurrentTask(handles.listboxTasks,'~ Setting the pick');
                else
                    showCurrentTask(handles.listboxTasks,'~ Disconnected');
                    taskStep = 100;
                end
            end
        end
    case 'goPickCheck'
        switch  robSTAT
            case 'GREEN'
                showCurrentTask(handles.listboxTasks,'~ On top of pick');
                taskCur = 'goPickDown';
            case 'RED'
                showCurrentTask(handles.listboxTasks,'~ Disconnected');
                taskStep = 100;
            case 'YELLOW'
                showCurrentTask(handles.listboxTasks,'~ Moving to pick');
        end        
    case 'goPickDown'
        for i = 1:4
            sumbodi=sum(order(1:i));
            if taskStep<=sumbodi
                X = REALPOS(i,1);Y = REALPOS(i,1);
                if strcmp(TOrobot(X,Y,148+(sumbodi-taskStep)*6.5 ,0,0,0),'DONE');
                    taskCur = 'goPickDownCheck';
                    showCurrentTask(handles.listboxTasks,'~ Going down to pick');
                else
                    showCurrentTask(handles.listboxTasks,'~ Disconnected');
                    taskStep = 100;
                end
            end
        end
    case 'goPickDownCheck'
        switch  robSTAT
            case 'GREEN'
                showCurrentTask(handles.listboxTasks,'~ On top of chocolate');
                taskCur = 'onVacumm';
            case 'RED'
                showCurrentTask(handles.listboxTasks,'~ Disconnected');
                taskStep = 100;
            case 'YELLOW'
                showCurrentTask(handles.listboxTasks,'~ Going down to pick');
        end  
    case 'onVacumm'
        TOio(1,1,0,0,300);
        showCurrentTask(handles.listboxTasks,'~ Turning on Vacumm');
        pause(0.5);      
        taskCur = 'goPickUp';
    case 'goPickUp'
        for i = 1:4
            sumbodi=sum(order(1:i));
            if taskStep<=sumbodi
                X = REALPOS(i,1);Y = REALPOS(i,1);
                if strcmp(TOrobot(X,Y,200,0,0,0),'DONE');
                    taskCur = 'goPickUpCheck';
                    showCurrentTask(handles.listboxTasks,'~ Picking up a chocolate');
                else
                    showCurrentTask(handles.listboxTasks,'~ Disconnected');
                    taskStep = 100;
                end
            end
        end
    case 'goPickUpCheck'
        switch  robSTAT
            case 'GREEN'
                showCurrentTask(handles.listboxTasks,'~ Above the stack chocolate');
                taskCur = 'goPlace';
            case 'RED'
                showCurrentTask(handles.listboxTasks,'~ Disconnected');
                taskStep = 100;
            case 'YELLOW'
                showCurrentTask(handles.listboxTasks,'~ Picking up a chocolate');
        end  
        
    case 'goPlace'%%%
        try
            imgConv=getsnapshot(handles.vid2); 
        catch
            imgConv=imread('converyor40.jpg');
        end
        [~,box] = NoPlotBoxConv(imgConv);
        for i = 1:4
            sumbodi=sum(order(1:i));
            if taskStep<=sumbodi
                boxReg = rem(taskStep,4);
                if boxReg==0
                    boxReg = 4;
                end
                X = box{1}.xy(boxReg,1); Y = box{1}.xy(boxReg,2);
                [X,Y] = conveyor2robot(X,Y);
                if strcmp(TOrobot(X,Y,200,0,0,rad2deg(box{1}.theta)+90),'DONE');
                    taskCur = 'goPlaceCheck';
                    showCurrentTask(handles.listboxTasks,'~ Moving to place');
                else
                    showCurrentTask(handles.listboxTasks,'~ Disconnected');
                    taskStep = 100;
                end
            end
        end
    case 'goPlaceCheck'%%%
        switch  robSTAT
            case 'GREEN'
                showCurrentTask(handles.listboxTasks,'~ On top of place');
                taskCur = 'goPlaceDown';
            case 'RED'
                showCurrentTask(handles.listboxTasks,'~ Disconnected');
                taskStep = 100;
            case 'YELLOW'
                showCurrentTask(handles.listboxTasks,'~ Moving to place');
        end  
    case 'goPlaceDown'%%
        try
            imgConv=getsnapshot(handles.vid2); 
        catch
            imgConv=imread('converyor40.jpg');
        end
        [~,box] = NoPlotBoxConv(imgConv);
        for i = 1:4
            sumbodi=sum(order(1:i));
            if taskStep<=sumbodi
                boxReg = rem(taskStep,4);
                if boxReg==0
                    boxReg = 4;
                end
                X = box{1}.xy(boxReg,1); Y = box{1}.xy(boxReg,2);
                [X,Y] = conveyor2robot(X,Y);
                if strcmp(TOrobot(X,Y,22.1+6.5*(taskStep-sumbodi),0,0,rad2deg(box{1}.theta)+90),'DONE');
                    taskCur = 'goPlaceDownCheck';
                    showCurrentTask(handles.listboxTasks,'~ Going down');
                else
                    showCurrentTask(handles.listboxTasks,'~ Disconnected');
                    taskStep = 100;
                end
            end
        end
    case 'goPlaceDownCheck'%%%
        switch  robSTAT
            case 'GREEN'
                showCurrentTask(handles.listboxTasks,'~ On top of chocolate');
                taskCur = 'goPlaceDown';
            case 'RED'
                showCurrentTask(handles.listboxTasks,'~ Disconnected');
                taskStep = 100;
            case 'YELLOW'
                showCurrentTask(handles.listboxTasks,'~ Going down');
        end  
    case 'offVacumm'%%%
        TOio(0,0,0,0,300);
        showCurrentTask(handles.listboxTasks,'~ Turning on Vacumm');
        pause(0.5);      
        taskCur = 'goPlaceUp';
    case 'goPlaceUp'%%%  
        try
            imgConv=getsnapshot(handles.vid2); 
        catch
            imgConv=imread('converyor40.jpg');
        end
        [~,box] = NoPlotBoxConv(imgConv);
        for i = 1:4
            sumbodi=sum(order(1:i));
            if taskStep<=sumbodi
                boxReg = rem(taskStep,4);
                if boxReg==0
                    boxReg = 4;
                end
                X = box{1}.xy(boxReg,1); Y = box{1}.xy(boxReg,2);
                [X,Y] = conveyor2robot(X,Y);
                if strcmp(TOrobot(X,Y,200),0,0,rad2deg(box{1}.theta)+90),'DONE');
                    taskCur = 'goPlaceDownCheck';
                    showCurrentTask(handles.listboxTasks,'~ Going up');
                else
                    showCurrentTask(handles.listboxTasks,'~ Disconnected');
                    taskStep = 100;
                end
            end
        end        
    case 'goPlaceUpCheck'
        switch  robSTAT
            case 'GREEN'
                showCurrentTask(handles.listboxTasks,'~ Done a placement');
                taskCur = 'goPick';
            case 'RED'
                showCurrentTask(handles.listboxTasks,'~ Disconnected');
                taskStep = 100;
            case 'YELLOW'
        end  
        taskCur = 'goPick';
        taskStep = taskStep+1;             
end

if taskStep > sum(order)
    showCurrentTask(handles.listboxTasks,'~ Finished the order');
    taskStep =0;
    stop(handles.timerOrder);
    return;
end
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

% --- Outputs from this function are returned to the command line.
function varargout = OrderGui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listboxTasks.
function listboxTasks_Callback(hObject, eventdata, handles)
% hObject    handle to listboxTasks (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listboxTasks contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listboxTasks


% --- Executes during object creation, after setting all properties.
function listboxTasks_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listboxTasks (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonPauseResume.
function pushbuttonPauseResume_Callback(hObject, eventdata, handles)

switch get(handles.pushbuttonPauseResume,'string')
    case 'Pause'
        stop(handles.timerOrder);
        stop(handles.timerCustomOrder);
        sender('S1'); 
        showCurrentTask(handles.listboxTasks, '~ pause current task');
        set(handles.pushbuttonPauseResume,'string','Resume')
    case 'Resume'
        start(handles.timerOrder);
        start(handles.timerCustomOrder);
        sender('S2'); 
        showCurrentTask(handles.listboxTasks, '~ resume current task');
        set(handles.pushbuttonPauseResume,'string','Pause')
end


% --- Executes on button press in pushbuttonCancel.
function pushbuttonCancel_Callback(hObject, eventdata, handles)
global taskStep taskCur
stop(handles.timerOrder);
stop(handles.timerCustomOrder);
taskStep = 1;
taskCur = 'Stop';
sender('S3');
showCurrentTask(handles.listboxTasks, '~ cancel order');


% --- Executes on button press in pushbutton_13.
function pushbutton_13_Callback(hObject, eventdata, handles)
h = gcbo;
if strcmp(get(handles.pushbutton_12,'string'),'none')
    uiwait(msgbox('fill the lower chocolates first'));
    return;
end
switch get(h,'string')
    case 'none'
        set(h,'string','milk','BackgroundColor',[.4 0.4 1]);
    case 'milk'
        set(h,'string','dark','BackgroundColor',[0.6 0.6 0.6]);
    case 'dark'
        set(h,'string','orange','BackgroundColor',[1 1 0]);
    case 'orange'
        set(h,'string','mint','BackgroundColor',[0 1 0]);
    case 'mint'
        set(h,'string','none','BackgroundColor',[1 1 1]);
end


% --- Executes on button press in pushbutton_12.
function pushbutton_12_Callback(hObject, eventdata, handles)
h = gcbo;
if strcmp(get(handles.pushbutton_11,'string'),'none')
    uiwait(msgbox('fill the lower chocolates first'));
    return;
end
switch get(h,'string')
    case 'none'
        set(h,'string','milk','BackgroundColor',[.4 0.4 1]);
    case 'milk'
        set(h,'string','dark','BackgroundColor',[0.6 0.6 0.6]);
    case 'dark'
        set(h,'string','orange','BackgroundColor',[1 1 0]);
    case 'orange'
        set(h,'string','mint','BackgroundColor',[0 1 0]);
    case 'mint'
        set(h,'string','none','BackgroundColor',[1 1 1]);
end


% --- Executes on button press in pushbutton_11.
function pushbutton_11_Callback(hObject, eventdata, handles)
h = gcbo;
switch get(h,'string')
    case 'none'
        set(h,'string','milk','BackgroundColor',[.4 0.4 1]);
    case 'milk'
        set(h,'string','dark','BackgroundColor',[0.6 0.6 0.6]);
    case 'dark'
        set(h,'string','orange','BackgroundColor',[1 1 0]);
    case 'orange'
        set(h,'string','mint','BackgroundColor',[0 1 0]);
    case 'mint'
        set(h,'string','none','BackgroundColor',[1 1 1]);
end


% --- Executes on button press in pushbutton_23.
function pushbutton_23_Callback(hObject, eventdata, handles)
h = gcbo;
if strcmp(get(handles.pushbutton_22,'string'),'none')
    uiwait(msgbox('fill the lower chocolates first'));
    return;
end
switch get(h,'string')
    case 'none'
        set(h,'string','milk','BackgroundColor',[.4 0.4 1]);
    case 'milk'
        set(h,'string','dark','BackgroundColor',[0.6 0.6 0.6]);
    case 'dark'
        set(h,'string','orange','BackgroundColor',[1 1 0]);
    case 'orange'
        set(h,'string','mint','BackgroundColor',[0 1 0]);
    case 'mint'
        set(h,'string','none','BackgroundColor',[1 1 1]);
end


% --- Executes on button press in pushbutton_22.
function pushbutton_22_Callback(hObject, eventdata, handles)
h = gcbo;
if strcmp(get(handles.pushbutton_21,'string'),'none')
    uiwait(msgbox('fill the lower chocolates first'));
    return;
end
switch get(h,'string')
    case 'none'
        set(h,'string','milk','BackgroundColor',[.4 0.4 1]);
    case 'milk'
        set(h,'string','dark','BackgroundColor',[0.6 0.6 0.6]);
    case 'dark'
        set(h,'string','orange','BackgroundColor',[1 1 0]);
    case 'orange'
        set(h,'string','mint','BackgroundColor',[0 1 0]);
    case 'mint'
        set(h,'string','none','BackgroundColor',[1 1 1]);
end


% --- Executes on button press in pushbutton_21.
function pushbutton_21_Callback(hObject, eventdata, handles)
h = gcbo;
switch get(h,'string')
    case 'none'
        set(h,'string','milk','BackgroundColor',[.4 0.4 1]);
    case 'milk'
        set(h,'string','dark','BackgroundColor',[0.6 0.6 0.6]);
    case 'dark'
        set(h,'string','orange','BackgroundColor',[1 1 0]);
    case 'orange'
        set(h,'string','mint','BackgroundColor',[0 1 0]);
    case 'mint'
        set(h,'string','none','BackgroundColor',[1 1 1]);
end


% --- Executes on button press in pushbutton_41.
function pushbutton_41_Callback(hObject, eventdata, handles)
h = gcbo;
switch get(h,'string')
    case 'none'
        set(h,'string','milk','BackgroundColor',[.4 0.4 1]);
    case 'milk'
        set(h,'string','dark','BackgroundColor',[0.6 0.6 0.6]);
    case 'dark'
        set(h,'string','orange','BackgroundColor',[1 1 0]);
    case 'orange'
        set(h,'string','mint','BackgroundColor',[0 1 0]);
    case 'mint'
        set(h,'string','none','BackgroundColor',[1 1 1]);
end


% --- Executes on button press in pushbutton_42.
function pushbutton_42_Callback(hObject, eventdata, handles)
h = gcbo;
if strcmp(get(handles.pushbutton_41,'string'),'none')
    uiwait(msgbox('fill the lower chocolates first'));
    return;
end
switch get(h,'string')
    case 'none'
        set(h,'string','milk','BackgroundColor',[.4 0.4 1]);
    case 'milk'
        set(h,'string','dark','BackgroundColor',[0.6 0.6 0.6]);
    case 'dark'
        set(h,'string','orange','BackgroundColor',[1 1 0]);
    case 'orange'
        set(h,'string','mint','BackgroundColor',[0 1 0]);
    case 'mint'
        set(h,'string','none','BackgroundColor',[1 1 1]);
end


% --- Executes on button press in pushbutton_43.
function pushbutton_43_Callback(hObject, eventdata, handles)
h = gcbo;
if strcmp(get(handles.pushbutton_42,'string'),'none')
    uiwait(msgbox('fill the lower chocolates first'));
    return;
end
switch get(h,'string')
    case 'none'
        set(h,'string','milk','BackgroundColor',[.4 0.4 1]);
    case 'milk'
        set(h,'string','dark','BackgroundColor',[0.6 0.6 0.6]);
    case 'dark'
        set(h,'string','orange','BackgroundColor',[1 1 0]);
    case 'orange'
        set(h,'string','mint','BackgroundColor',[0 1 0]);
    case 'mint'
        set(h,'string','none','BackgroundColor',[1 1 1]);
end

function pushbutton_31_Callback(hObject, eventdata, handles)
h = gcbo;
switch get(h,'string')
    case 'none'
        set(h,'string','milk','BackgroundColor',[.4 0.4 1]);
    case 'milk'
        set(h,'string','dark','BackgroundColor',[0.6 0.6 0.6]);
    case 'dark'
        set(h,'string','orange','BackgroundColor',[1 1 0]);
    case 'orange'
        set(h,'string','mint','BackgroundColor',[0 1 0]);
    case 'mint'
        set(h,'string','none','BackgroundColor',[1 1 1]);
end

function pushbutton_32_Callback(hObject, eventdata, handles)
h = gcbo;
if strcmp(get(handles.pushbutton_31,'string'),'none')
    uiwait(msgbox('fill the lower chocolates first'));
    return;
end
switch get(h,'string')
    case 'none'
        set(h,'string','milk','BackgroundColor',[.4 0.4 1]);
    case 'milk'
        set(h,'string','dark','BackgroundColor',[0.6 0.6 0.6]);
    case 'dark'
        set(h,'string','orange','BackgroundColor',[1 1 0]);
    case 'orange'
        set(h,'string','mint','BackgroundColor',[0 1 0]);
    case 'mint'
        set(h,'string','none','BackgroundColor',[1 1 1]);
end


function pushbutton_33_Callback(hObject, eventdata, handles)
h = gcbo;
if strcmp(get(handles.pushbutton_32,'string'),'none')
    uiwait(msgbox('fill the lower chocolates first'));
    return;
end
switch get(h,'string')
    case 'none'
        set(h,'string','milk','BackgroundColor',[.4 0.4 1]);
    case 'milk'
        set(h,'string','dark','BackgroundColor',[0.6 0.6 0.6]);
    case 'dark'
        set(h,'string','orange','BackgroundColor',[1 1 0]);
    case 'orange'
        set(h,'string','mint','BackgroundColor',[0 1 0]);
    case 'mint'
        set(h,'string','none','BackgroundColor',[1 1 1]);
end

% --- Order by number of Flavours
function pushbuttonMake_Callback(hObject, eventdata, handles)
global order avail taskStep taskCur
%......checking the data.....................
taskStep = 1;
taskCur  = 'goPick';
try
    if strcmpi(get(handles.editMilk,'string'),'all')
        order(1,1) = avail(1,1);
    else
        order(1,1)    = str2num(get(handles.editMilk,'string'));
    end
    if strcmpi(get(handles.editDark,'string'),'all')
        order(1,2) = avail(1,2);
    else
        order(1,2)    = str2num(get(handles.editDark,'string'));
    end
    if strcmpi(get(handles.editOrange,'string'),'all')
        order(1,3) = avail(1,3);
    else
        order(1,3)    = str2num(get(handles.editOrange,'string'));
    end
    if strcmpi(get(handles.editMint,'string'),'all')
        order(1,4) = avail(1,4);
    else
        order(1,4)    = str2num(get(handles.editMint,'string'));
    end
    
catch
    order=[0,0,0,0];
    set(handles.editMilk,'string','0');
    set(handles.editDark,'string','0');
    set(handles.editOrange,'string','0');
    set(handles.editMint,'string','0');
    uiwait(errordlg('invalid number of chocolates','1'));
    return;
end
for i=1:4
    if order(1,i)>6 ||  order(1,i)<0
        order=[0,0,0,0];
        set(handles.editMilk,'string','0');
        set(handles.editDark,'string','0');
        set(handles.editOrange,'string','0');
        set(handles.editMint,'string','0');
        uiwait(errordlg('invalid number of chocolates','2'));
        return;
    end
end
showCurrentTask(handles.listboxTasks,['~ new order : ' num2str(order)]);


order
%......................
run(handles.timerOrder);
guidata(hObject, handles);

function editMint_Callback(hObject, eventdata, handles)
% hObject    handle to editMint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editMint as text
%        str2double(get(hObject,'String')) returns contents of editMint as a double


% --- Executes during object creation, after setting all properties.
function editMint_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editMint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editOrange_Callback(hObject, eventdata, handles)
% hObject    handle to editOrange (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editOrange as text
%        str2double(get(hObject,'String')) returns contents of editOrange as a double


% --- Executes during object creation, after setting all properties.
function editOrange_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editOrange (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editDark_Callback(hObject, eventdata, handles)
% hObject    handle to editDark (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editDark as text
%        str2double(get(hObject,'String')) returns contents of editDark as a double


% --- Executes during object creation, after setting all properties.
function editDark_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editDark (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editMilk_Callback(hObject, eventdata, handles)
% hObject    handle to editMilk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editMilk as text
%        str2double(get(hObject,'String')) returns contents of editMilk as a double


% --- Executes during object creation, after setting all properties.
function editMilk_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editMilk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonMakeCustom.
function pushbuttonMakeCustom_Callback(hObject, eventdata, handles)
global orderCustom avail taskStep taskCur
taskStep = 1;
taskCur  = 'goPick';

temp = zeros(3,4);
temp(1,1) = str2flv(get(handles.pushbutton_11,'string'));
temp(2,1) = str2flv(get(handles.pushbutton_12,'string'));
temp(3,1) = str2flv(get(handles.pushbutton_13,'string'));
temp(1,2) = str2flv(get(handles.pushbutton_21,'string'));
temp(2,2) = str2flv(get(handles.pushbutton_22,'string'));
temp(3,2) = str2flv(get(handles.pushbutton_23,'string'));
temp(1,3) = str2flv(get(handles.pushbutton_31,'string'));
temp(2,3) = str2flv(get(handles.pushbutton_32,'string'));
temp(3,3) = str2flv(get(handles.pushbutton_33,'string'));
temp(1,4) = str2flv(get(handles.pushbutton_41,'string'));
temp(2,4) = str2flv(get(handles.pushbutton_42,'string'));
temp(3,4) = str2flv(get(handles.pushbutton_43,'string'));
orderCustom = temp;

showCurrentTask(handles.listboxTasks,[num2str(orderCustom)]);
showCurrentTask(handles.listboxTasks, '~ new custom order');

% run(handles.timerOrderCustom);
guidata(hObject, handles);


function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to editMilk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editMilk as text
%        str2double(get(hObject,'String')) returns contents of editMilk as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editMilk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
