% function z = getZloc(array of [X Y theta],  currentStep(of robot)) 
%% Get the coordinates by calculating how many choc was stacked
function [ X, Y, Z, theta] = getZloc(xyt, C) 
X = xyt(C,1);
Y = xyt(C,2);
theta = xyt(C,3);

stack = length(find(( xyt(1:C,1) < X+10) && (xyt(1:C,1) > X-10)...
    && (xyt(1:C,2) < Y+10) && (xyt(1:C,2) > Y-10) ));

if X>128
    Z = 147 + stack*6;
else
    Z = 22.1 + stack*6;
end

return