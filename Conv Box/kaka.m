clear; close all;
x = [1 2  3 4 5 3];
y = [23  45 67 34 23 1];
z = [0 0 0 0 0 0 ];
plot(x,y,'ro');hold on;
% kk = minBoundingBox([x; y]);
% kk(:,end+1)=kk(:,1);
% plot(kk(1,:), kk(2,:),'b');

[~,cornerpoints,~,~,~] = minboundbox(x,y,z);