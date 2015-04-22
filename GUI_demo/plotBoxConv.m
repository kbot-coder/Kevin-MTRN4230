function plotBoxConv(im)
%to be call in timer func
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
hold off;
end

function BW = pizza(RGB)
I = rgb2hsv(RGB);
channel1Min = 0.000;
channel1Max = 1.000;
channel2Min = 0.069;
channel2Max = 1.000;
channel3Min = 0.000;
channel3Max = 0.646;
BW = (I(:,:,1) >= channel1Min ) & (I(:,:,1) <= channel1Max) & ...
    (I(:,:,2) >= channel2Min ) & (I(:,:,2) <= channel2Max) & ...
    (I(:,:,3) >= channel3Min ) & (I(:,:,3) <= channel3Max);
BW = ~BW;

end