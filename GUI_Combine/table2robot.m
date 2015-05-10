function [Xr,Yr] = table2robot(Xt,Yt)
R = [0 1 ; 1 0];
S = [0.65 0 ; 0 0.65];
T = [77.5 ; -520];
TCoor = [Xt ; Yt];

RCoor = R*S*TCoor + T;
Xr = int32(RCoor(1));
Yr = int32(RCoor(2));
return