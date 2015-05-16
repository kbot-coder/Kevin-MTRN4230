function c = point_maker(N)
close all;
i=0;

while i<N 
    x = randi([175,548]);
    y = randi([-520,520]);
    theta = randi([-180,180]);
    flavour = randi([1,4]);   
    xCenter = 175;
    yCenter = 0;
    yRadius = 520;
    xRadius = 373;
    true_value = 0;
    while true_value == 0
        result = ((x-xCenter)^2/(xRadius^2)) + ((y-yCenter)^2/(yRadius)^2);
        
        if result <= 1
            break;
        elseif result > 1
            x = randi([175,548]);
            
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
    theta = -pi/2 : 0.01 : pi/2;
    x = xRadius * cos(theta) + xCenter;
    y = yRadius * sin(theta) + yCenter;
    plot(x, y, 'LineWidth', 1);
    hold on
    axis([175 550 -520 520]);
end