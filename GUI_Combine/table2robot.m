% convert pixel coordinate from TABLE camera to robot coordinate 

function [Xr,Yr] = table2robot(Xt,Yt)
for i=1:length(Xt),
    R = [0 1 ; 1 0];
    S = [0.65 0 ; 0 0.65];
    T = [77.5 ; -520];
    TCoor = [Xt(i) ; Yt(i)];

    RCoor = R*S*TCoor + T;
    Xr(i) = (RCoor(1));
    Yr(i) = (RCoor(2));
end
return