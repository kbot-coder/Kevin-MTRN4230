%# data
X = {
    'Alice'   'roni'
    'Bob'     'roni'
    'Charlie' 'roni'
    'Dave'    'roni'
};

%# get color from user
c = uisetcolor();

%# format color as: rgb(255,255,255)
%#clr = sprintf('rgb(%d,%d,%d)', round(c*255));

%# format color as: #FFFFFF
clr = dec2hex(round(c*255),2)'; 
clr = ['#';clr(:)]';

%# apply formatting to third row first column
X = strcat(...
    ['<html><body bgcolor="' clr '" text="#FF0000" width="100px">'], ...
    X);

%# display table
f = figure('Position',[100 100 350 150]);
h = uitable('Parent',f, 'ColumnWidth',{100 'auto'}, ...
    'Units','normalized', 'Position',[0.05 0.05 0.9 0.9], ...
    'Data',X, 'ColumnName',{'Name','Rank'}, 'RowName',[]);