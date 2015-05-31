function [in] = checkPoint(xx , yy , X , Y,  theta)
reff = [-89,41 ; 89,41 ; 89,-41 ; -89,-41 ; -89,41];
reff = reff';
Rot = [cos(theta) , -sin(theta) ; sin(theta) , cos(theta)];
rectangle = Rot*reff;
rectangle = [rectangle(1,:)+X ; rectangle(2,:)+Y];
inside = inpolygon(xx,yy,rectangle(1,:),rectangle(2,:));
if inside==0,
    in = 0;
else
    in=1;
end
return;