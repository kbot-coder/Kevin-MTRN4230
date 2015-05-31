function showCurrentTask(h,new_line)

initial_task = cellstr(get(h,'String'));
new_task     = [{new_line}; initial_task];
set(h,'string',new_task);
end