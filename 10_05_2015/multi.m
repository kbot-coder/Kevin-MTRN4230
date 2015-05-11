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
elseif mode == 4
sender('[175,-520,150]');
pause(0.01);
sender('[0,0,1,0,0,0]');
pause(0.01);
sender('START');
pause(1.8);
sender('S3');
pause(0.1);
sender('S2');
pause(0.01);
sender('[175,520,150]');
pause(0.01);
sender('[0,0,1,0,0,0]');
pause(0.01);
sender('START');
pause(1.9)
sender('[175,-520,150]');
pause(0.01);
sender('[0,0,1,0,0,0]');
pause(0.01);
sender('START');
pause(2.5);
sender('S3');
pause(0.1);
sender('S2');
pause(0.01);
sender('[175,520,150]');
pause(0.01);
sender('[0,0,1,0,0,0]');
pause(0.01);
sender('START');
end
