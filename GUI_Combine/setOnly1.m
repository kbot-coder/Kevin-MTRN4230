% Set the selection to only one selection box for the flavour
function setOnly1(flav , amount,hObject, eventdata, handles)
    switch flav
        case 'Milk'
            set(handles.selectMilk,'value',1);
            set(handles.selectDark,'value',0);
            set(handles.selectOrange,'value',0);
            set(handles.selectMint,'value',0);
            set(handles.selectBack,'value',0);    
            set(handles.nMilkInput,'string',amount);
        case 'Dark'
            set(handles.selectMilk,'value',0);
            set(handles.selectDark,'value',1);
            set(handles.selectOrange,'value',0);
            set(handles.selectMint,'value',0);
            set(handles.selectBack,'value',0);
            set(handles.nDarkInput,'string',amount);            
        case 'Orange'
            set(handles.selectMilk,'value',0);
            set(handles.selectDark,'value',0);
            set(handles.selectOrange,'value',1);
            set(handles.selectMint,'value',0);
            set(handles.selectBack,'value',0);
            set(handles.nOrangeInput,'string',amount);  
        case 'Mint'
            set(handles.selectMilk,'value',0);
            set(handles.selectDark,'value',0);
            set(handles.selectOrange,'value',0);
            set(handles.selectMint,'value',1);
            set(handles.selectBack,'value',0);
            set(handles.nMintInput,'string',amount);
        case 'Back'
            set(handles.selectMilk,'value',0);
            set(handles.selectDark,'value',0);
            set(handles.selectOrange,'value',0);
            set(handles.selectMint,'value',0);
            set(handles.selectBack,'value',1);           
            set(handles.nBackInput,'string',amount);          
    end
    guidata(hObject, handles);
end