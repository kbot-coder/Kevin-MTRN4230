%-------------------Function to Test Reachability--------------------------
% Input  : detected chocolate centroid
% Output : reachable or no
%--------------------------------------------------------------------------

function yesno = elip(centroidX,centroidY)
    %if reachable return 1 if not return 0
    %initial value
    xCenter = 807;
    yCenter = 757;
    xRadius = 797;
    yRadius = 570;
    
    %calculation region of interest as an ellipse
    result = (((centroidX-xCenter)^2/xRadius^2) + ((centroidY-yCenter)^2/yRadius^2));
        
    %return
    % result =1 --> reachable if the centroid inside the region of interest
    % otherwise result = 0 --> not reachable
    if result <=1
        yesno =1;
    else
        yesno =0;
    end   
end
