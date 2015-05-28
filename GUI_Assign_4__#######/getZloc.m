% function z = getZloc(array of [X Y theta],  currentStep(of robot)) 
%% Get the coordinates by calculating how many choc was stacked
function [ X, Y, Z, theta] = getZloc(xyt, C, where) 
X = xyt(C,1);
Y = xyt(C,2);
theta = xyt(C,3);

switch where
    case 'PICK'
        if X>128           
            Z = 145;% On the table
        else
            Z = 20.16;% On the conveyor
        end

    case 'PLACE'
        range = sqrt( (X-xyt(:,1)).^2 + (X-xyt(:,2)).^2  ); 
        stack = size(find(range(1:C,1)<7));
        if X>128
            Z = 145 + 6.5*stack(1);% On the table
        else
            Z = 20.1 + 6.5*stack(1) ;% On the conveyor
        end
end
stack =1;
if X>128
    % On the table
    Z = 145 + stack*6;
else
    % On the conveyor
    Z = 20.1 + stack*6;
end

return