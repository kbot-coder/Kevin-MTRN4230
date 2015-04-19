%%PLOTTING THE CENTER AND THE Rectangle OF THE BOX
function conveyorThingy(im)
    I2 = im;
    I2 = pizza(im); 
    I2(:, 1:235) = 0;
    I2(1:117, :) = 0;
    I2(360:end, :) = 0;

    k = bwareaopen(I2,100);
    k = bwconvhull(k,'object');
    k = bwareaopen(k,100); 
    k = imclose(k,ones(2, 2));
    k = imopen(k,ones(3, 3));
    k = bwareaopen(k,1000);
    
    imshow(im);
    hold on;
    s = regionprops(k,'orientation','centroid');
    for i=1:100
        if i>length(s)
            break;
        end
        cT = cos(s(i).Orientation/180*pi);
        sT = sin(s(i).Orientation/180*pi);   
        xs = [70, 70, -70, -70, 70];
        ys = [38, -38, -38, 38, 38];
        rec = [cT , sT; -sT, cT]*[xs;ys]+...
            [s(i).Centroid' s(i).Centroid' s(i).Centroid' s(i).Centroid' s(i).Centroid'];
        plot(s(i).Centroid(1),s(i).Centroid(2),'ro');
        plot(rec(1,:),rec(2,:),'g');
    end

end