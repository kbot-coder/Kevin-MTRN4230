
function yesno = reachable(XCent,YCent)
    xCenter = 807;
    yCenter = 757;
    xRadius = 797;
    yRadius = 570;
    
    result = (((XCent-xCenter)^2/xRadius^2) + ((YCent-yCenter)^2/yRadius^2));
    
    if result <=1
        yesno =1;
    else
        yesno =0;
    end

end