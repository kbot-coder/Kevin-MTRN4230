function runRobot(pickTarget,placeTarget)
if length(pickTarget(:,1))==length(placeTarget(:,1)),
    for i=1:length(pickTarget(:,1)),
        pick(pickTarget(i,:))
        adjustTheta(placeTarget(i,4)-pickTarget(i,4))
        place(placeTarget(i,:))
    end
    msgbox('Operation Completed');
else
    errordlg('Unbalance Pick & Place Target'); 
end
return

function pick(pickTarget)
X = pickTarget(1);
Y = pickTarget(2);
Z = pickTarget(3);
run_vacuum_pump
go_to(X,Y,Z)
run_soneloid_valve
go_to(X,Y,Z+100)
return

function place(placeTarget)
X = placeTarget(1);
Y = placeTarget(2);
Z = placeTarget(3);
go_to(X,Y,Z)
stop_soneloid_valve
stop_vacuum_pump
go_to(X,Y,Z+100)
return

function run_vacuum_pump()
return

function stop_vacuum_pump()
return

function run_soneloid_valve()
return

function stop_soneloid_valve()
return

function go_to(X,Y,Z)
return

function adjustTheta(delta)
return