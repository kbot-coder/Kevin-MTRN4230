% convert pixel coordinate from TABLE camera to robot coordinate 

function [Xr,Yr] = table2robot(Xt,Yt)
R = [0 1 ; 1 0];
S = [0.65 0 ; 0 0.65];
T = [77.5 ; -520];
TCoor = [Xt ; Yt];

RCoor = R*S*TCoor + T;
Xr = (RCoor(1));
Yr = (RCoor(2));
return