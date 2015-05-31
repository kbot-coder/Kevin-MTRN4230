%Flip the chocolate by dropping the unknown chocolate at the table edge.

function flip_choc_to_conv(target_x, target_y, target_ori)
    chocThickness = 5;
    tableHeight = 147;
    dropHeight = 50;
    target_z = chocThickness + tableHeight;

    %pick the target chocolate
    ret = TOrobot(target_x, target_y, target_z, 0, 0, target_ori);
    if strcmp('DONE', ret)
        waiting;
        TOio(1,1,0,0,300);
        pause(1.5);
    end

    % drop the chocolate on the edge of the table
    ret = TOrobot(135,400, tableHeight + dropHeight, 0, 0, 90);
    if strcmp('DONE', ret)
        waiting;
        TOio(0,0,0,0,300);
        pause(1.5);
    end

    % move the robot to T1 position
    ret = TOrobot(175,0,tableHeight,0,0,0);
    if strcmp('DONE', ret)
        waiting;
    end
end



