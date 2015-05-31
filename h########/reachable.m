% find if the choc is reachable by the robot arm or not.
function [pick]= reachable(X,Y)

if (((X-800)^2)/(800^2) + ((Y-143)^2)/(570^2)) <=1
    pick = 1;
else
    pick = 0;
end
                 
                  