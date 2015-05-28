function plotTarget(data)
for i = 1:length(data(:,1)),
    reff = [-89,41 ; 89,41 ; 89,-41 ; -89,-41 ; -89,41];
    reff = reff';
    Rot = [cos(data(i,3)) , -sin(data(i,3)) ; sin(data(i,3)) , cos(data(i,3))];
    rectangle = Rot*reff;
    rectangle = [rectangle(1,:)+data(i,1) ; rectangle(2,:)+data(i,2)];
    line(rectangle(1,:),rectangle(2,:),'linewidth',2,'color','r');
end
return;