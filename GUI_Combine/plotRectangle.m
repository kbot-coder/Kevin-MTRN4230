function plotRectangle(X , Y,  theta)
reff = [-89,41 ; 89,41 ; 89,-41 ; -89,-41 ; -89,41];
reff = reff';
Rot = [cos(theta) , -sin(theta) ; sin(theta) , cos(theta)];
rectangle = Rot*reff;
rectangle = [rectangle(1,:)+X ; rectangle(2,:)+Y];
line(rectangle(1,:),rectangle(2,:),'linewidth',5,'color','b');
return;