function SendData(mode,data)

switch mode
    case 0,
        data = LinData;
        send
    case 1,
        data = JointData;
        send
    case 2,
        calib
        send
    case 3,
        data = IO_Data;
        send
    case 5,
        %Send pause
        send
    case 6,
        %send resume
        send
end

return