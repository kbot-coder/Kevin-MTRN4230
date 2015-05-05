function [Xr,Yr] = conveyor2robot(Xc,Yc)
R = [-1 0 ; 0 1];
S = [1.5 0 ; 0 1.5];
T = [482.5 ; 62.5];
CCoor = [Xc ; Yc];

RCoor = R*S*CCoor + T;
Xr = RCoor(1);
Yr = RCoor(2);
return