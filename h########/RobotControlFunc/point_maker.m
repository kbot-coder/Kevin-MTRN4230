function c = point_maker(N)
close all;
i=0;

while i<N 
     y = randi([143,713]);
    x = randi([0,1600]);
    theta = randi([-180,180]);
    flavour = randi([1,5]);   
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
    %draw rectangle
    w = 81;  %witdth
    h = 170;  % heigh
    angle = c(i,3); %orientation
    
    X = [-w/2 w/2 w/2 -w/2 -w/2];
    Y = [h/2 h/2 -h/2 -h/2 h/2];
    P = [X;Y];
    ct = cos(angle);
    st = sin(angle);
    R = [ct -st;st ct];
    P = R * P;
    
    if c(i,4) == 1
        type = 'b'; %milk
        else if c(i,4) == 2
            type = 'k'; %dark    
            else if c(i,4) == 3
                type = 'y'; %orange
                else if c(i,4) == 4
                    type = 'g'; %mint 
                    else c(i,4) == 5
                        type = 'm'; %unknown  
                    end
                end
        end
    end
    axis equal;
    figure(1)
    plot(c(i,1),c(i,2),'ro');
    plot(P(1,:)+c(i,1),P(2,:)+c(i,2),type);
    hold on
    
end
    theta = 0 : 0.01 : pi;
    x = xRadius * cos(theta) + xCenter;
    y = yRadius * sin(theta) + yCenter;
    plot(x, y, 'LineWidth', 1);
    hold on
    axis([175 550 -520 520]);
    axis([0 1600 0 900]);
end