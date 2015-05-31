% convert pixel coordinate from CONVEYOR camera to robot coordinate 

function [Xr,Yr] = conveyor2robot(Xt,Yt)

ratX = 1.4839; %ratio robot coordinate to pixel coordinate
ratY = 1.7; 

S = [ratX ; ratY];
T = [-320 ; 0];

TCoor = [640;480]-[Xt ; Yt];

RCoor = (TCoor + T).*S;
Xr = (RCoor(1));
Yr = (RCoor(2));

return