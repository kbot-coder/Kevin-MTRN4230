function kevin_test_runner(N,y)
    persistent x 
    c=point_maker(N);
    [sizeL,~] = size(c);
    sizeL
    i=0;
    while i<sizeL
        
        if y==1
        flip_choc_v2(200,0,175,500,90,c(i+1,1),c(i+1,2),c(i+1,3),'RESET')
        y=0;
            i=i+1;
        else
            i=i+1;
        flip_choc_v2(200,0,175,500,90,c(i,1),c(i,2),c(i,3),'')
        pause(0.5);
    
        end
    end

    
        