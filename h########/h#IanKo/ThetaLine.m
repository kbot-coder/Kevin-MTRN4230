function LineArray = ThetaLine(A,B,theta)
    
    length = 100;
    Line_x = A + length*cos(theta);
    Line_y = B + length*sin(theta);
    
    LineArray(1)=   Line_x;
    LineArray(2)=   Line_y;
end