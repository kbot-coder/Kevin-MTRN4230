function multi(mode)
if mode == 1
sender('[175,520,150]');
pause(0.0001);
sender('[0,0,1,0,0,0]');
pause(0.0001);
sender('START');
elseif mode == 2
sender('[175,-520,150]');
pause(0.0001);
sender('[0,0,1,0,0,0]');
pause(0.0001);
sender('START');
elseif mode == 3
sender('[0,0,0,0,100,0]');
pause(0.0001);
sender('STRIO');    
end
