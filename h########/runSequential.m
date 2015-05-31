handles.process = length(data)*4;
if handles.process~=0,
    if green,
        handles.step = handles.step+1;
        if handles.step == 1,
            goto(Xpick,Ypick,Zpick,thetaPick);
            handles.step = 2;
        elseif handles.step == 2,
            pickChocolate
            handles.step = 3;
        elseif handles.step == 3,
            goto(Xplace,Yplace,Zplace,thetaPlace);
            handles.step =4;
        elseif handles.step == 4,
            placeChocolate
            handles.step = 1;
            handles.process = process-1;
        end
    end
end