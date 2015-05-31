% assume there will be no disconnection
% OnOffVac: turn the vac on or off after it went down
% downup: how much to go down at the location
function moveDownUp(x,y,z,theta,OnOffVac,downup)
success =0;
if strcmp(TOrobot(x,y,z,0,0,theta),'DONE')
    waiting;
    %go down
    if strcmp(TOrobot(x,y,z-downup,0,0,theta),'DONE')
        waiting;
        TOio(OnOffVac,OnOffVac,0,0,300);
        pause(1);
        
        %go up
        if strcmp(TOrobot(x,y,z,0,0,theta),'DONE')
           waiting;
           success =1;
           return;
        end
    end
end
            

    
    
    
end