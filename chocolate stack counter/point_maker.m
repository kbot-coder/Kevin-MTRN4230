function c = point_maker(N)
close all;
i=0;
% function [pick]= reachable(X,Y)
% 
% if (((X-800)^2)/(800^2) + ((Y-143)^2)/(570^2)) <=1
%     pick = 1;
% else
%     pick = 0;
% end
while i<N 
    y = randi([143,713]);
    x = randi([0,1600]);
    theta = randi([-180,180]);
    flavour = randi([1,4]);   
    xCenter = 800;
    yCenter = 143;
    yRadius = 570;
    xRadius = 800;
    true_value = 0;
    while true_value == 0
        result = ((x-xCenter)^2/(xRadius^2)) + ((y-yCenter)^2/(yRadius)^2);
        
        if result <= 1
            break;
        elseif result > 1
            y = randi([143,713]);
            
        end
    end
    i=i+1;
    c(i,1) = x;
    c(i,2) = y;
    c(i,3) = theta;
    c(i,4) = flavour;
    figure(1)
    plot(c(i,1),c(i,2),'ro');
    hold on
    
end
    theta = 0 : 0.01 : pi;
    x = xRadius * cos(theta) + xCenter;
    y = yRadius * sin(theta) + yCenter;
    plot(x, y, 'LineWidth', 1);
    hold on
    axis([0 1600 0 900]);
end