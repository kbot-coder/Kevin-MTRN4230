%-----------------CHOCOLATE DETECTION FUNCTION-----------------------------
% Input     : Image im from capture snapshoot
% Output    : Detected chocolate data in matrix c --> centroid, flavour,
% top/bottom, reachability, pickability
%--------------------------------------------------------------------------

function c = detect_chocolates(im)

%Initial Variable
feaST = cell (120,1);
chocFeatures = cell (1,120);
sampleIM =1;
data = zeros(30,10);
iterate = 0;
counter = 0;
cancelLoop =0;
NoIte = 2;
threshold = 120;

%Read and modified target image
target = im;
targetgray = rgb2gray(target);
[sizeTargetIM_Y,~] = size(target);


%pass image to reader function & find the validity of the return value
vldMatrice = reader(im);
validity = find(vldMatrice == 1);
[~,valid] = size(validity);

if valid ==0
    
    %if invalid cancel the whole loop : to prevent crash
    cancelLoop =1;

else
   
    %send the validity matrices to feature reader and store it in array
    %form
    [feaST,chocFeatures,Samplegray,MaxSize,seperator] = featureReader(vldMatrice);
    
    %detect the target image features
    targetPoints = detectSURFFeatures(targetgray,'MetricThreshold',threshold);
    [targetFeatures, targetPoints] = extractFeatures(targetgray, targetPoints);
    
end

while cancelLoop ~= 1
    
   %sampleIm is the counter of the image and to prevent to go over the the
   %max sample the below if is used
   if sampleIM ==(MaxSize+1) && iterate < NoIte
        iterate=iterate +1;
        sampleIM=1;
       
       
   elseif sampleIM==(MaxSize+1) && iterate >=NoIte
        sampleIM=sampleIM-1;
%        targetPoints = detectSURFFeatures(targetgray,'MetricThreshold',threshold);
        
        %cancel the loop
        cancelLoop =  cancelLoop +1;

   end
   
    

    %Pairing the target and sample image
    Pairs = matchFeatures(chocFeatures{sampleIM}, targetFeatures,'MatchThreshold' , 20 ); 
    [PairsX,~]=size(Pairs(:,1));
    
    %check if target image has min required points
    if PairsX >= 9
        
        %matched points between target and sample
        matchedCHOCPoints = feaST{sampleIM}(Pairs(:, 1), :);
        matchedTARGETPoints = targetPoints(Pairs(:, 2), :);

        %present match features and matching process (really cool)
%       figure(2);
%       showMatchedFeatures(Samplegray{sampleIM}, targetgray, matchedCHOCPoints,matchedTARGETPoints, 'montage');
   
   
        %transform and calculate the number of inlier point
        [tform, inlierMILKPoints, ~,status] = estimateGeometricTransform(matchedCHOCPoints, matchedTARGETPoints, 'affine','MaxDistance',6);
        [inX,~]= size(inlierMILKPoints);
        
        %check if the inlier point are sufficient
        if inX>=2 && status == 0 
                    
          
            %the polygon of the sample image size
            boxPolygon = [1, 1;...                           % top-left
            size(Samplegray{sampleIM}, 2), 1;...                 % top-right
            size(Samplegray{sampleIM}, 2), size(Samplegray{sampleIM}, 1);... % bottom-right
            1, size(Samplegray{sampleIM}, 1);...                 % bottom-left
            1, 1];                   % top-left again to close the polygon

            %transformation method of the polygon to target image  
            newBoxPolygon = transformPointsForward(tform, boxPolygon);
            
            
            %final check if the polygon square or not( if square then it is
            %valid chocolate)
            %diagonal 1
            Check1x = newBoxPolygon(1,1)-newBoxPolygon(3,1);
            Check1y = newBoxPolygon(1,2)-newBoxPolygon(3,2);
            Check1  = sqrt(Check1x^2 + Check1y^2);
            %diagonal 2
            Check2x = newBoxPolygon(2,1)-newBoxPolygon(4,1);
            Check2y = newBoxPolygon(4,2)-newBoxPolygon(2,2);
            Check2  = sqrt(Check2x^2 + Check2y^2);
            %length
            Check3x = newBoxPolygon(1,1)-newBoxPolygon(4,1);
            Check3y = newBoxPolygon(1,2)-newBoxPolygon(4,2);
            Check3 = sqrt( Check3x^2 + Check3y^2);
            %width
            Check4x = newBoxPolygon(1,1)-newBoxPolygon(2,1);
            Check4y = newBoxPolygon(1,2)-newBoxPolygon(2,2);
            Check4 = sqrt( Check4x^2 + Check4y^2);
            
            %validity of polygon shape
            if (Check1 < (Check2 +10) && Check1 > (Check2-10)) && (Check1 < 230 &&(Check3> 75 && Check3<100))&& Check4 > 170
                
                %centroid of chocolate
                Centroid_x = mean(newBoxPolygon(1:4,1));
                Centroid_y = mean(newBoxPolygon(1:4,2));
            
                %theta
                y_diff = newBoxPolygon(2,2)-newBoxPolygon(1,2);
                x_diff = newBoxPolygon(2,1)-newBoxPolygon(1,1);
                theta =  atan2(y_diff,x_diff);
                
                %pointer line
                LineArray= ThetaLine(Centroid_x,Centroid_y,theta);
                
                %storing data inarray
                counter =counter+1;              
                data(counter,1)= Centroid_x;
                data(counter,2)= Centroid_y;
                data(counter,3)= -theta;
                data(counter,8) = LineArray(1);
                data(counter,9) = LineArray(2);
                data(counter,6)=elip(Centroid_x,Centroid_y);
               
                %masking from polygon to binary
                storeXcoor = transpose(double(newBoxPolygon(:,1)));
                storeYcoor = transpose(double(newBoxPolygon(:,2)));
                
                masking = poly2mask(storeXcoor,storeYcoor,900,1600);
                masktarget = targetgray;
                masktarget ( masking==1)=0;
                targetgray = masktarget;
                
                %extract feature
                [targetFeatures, targetPoints] = extractFeatures(targetgray, targetPoints);
                
                %repeat when score a hit to ensure all chocolate  are
                %captured
                
                if sampleIM <= seperator(1,1)
                    
                    %loopback to 1st image
                    sampleIM = 1;
                    %store flavour
                    data(counter,7) = seperator(1,3);
                    data(counter,10) = sampleIM;
                    
                    
                elseif sampleIM <= seperator(2,1) && seperator (2,1) ~= 0
                    
                    %loopback to 1st image of 2nd type of choc 
                    sampleIM = seperator (1,1)+1;
                    
                    %store flavour
                    data(counter,7) = seperator(2,3);
                    data(counter,10) = sampleIM - seperator(1,1);
                                        
                    
                elseif sampleIM <= seperator(3,1) && seperator (3,1) ~= 0
                    
                    %loopback to 1st image of 3nd type of choc  
                    sampleIM = seperator (2,1)+1;
                    
                    %store flavour
                    data(counter,7) = seperator(3,3);
                    data(counter,10) = sampleIM - seperator(2,1);
                    
                    
                elseif sampleIM <= seperator(4,1) && seperator (4,1) ~= 0
                    
                    %loopback to 1st image of 4nd type of choc 
                    sampleIM = seperator (3,1)+1;
                    
                    %store flavour
                    data(counter,7) = seperator(4,3);
                    data(counter,10) = sampleIM - seperator(3,1);
                    
                elseif sampleIM <= seperator(5,1) && seperator (5,1) ~= 0
                    %loopback to 1st image of 5nd type of choc       
                    sampleIM = seperator (4,1)+1;
                    
                    %store flavour
                    data(counter,7) = seperator(5,3);
                    data(counter,10) = sampleIM - seperator(4,1);

                end
                        
            else
                
                sampleIM = sampleIM+1;
                
            end
            
        else
            
            sampleIM = sampleIM+1;
            
        end
        
    else
        
        sampleIM = sampleIM +1; 
        
    end
end

[YY , ~] = size(data(:,1));


%putting result in array form

for co = 1:YY
    if data(co,1) ~= 0 
    c(co,1) = data (co,1);                          %x
    c(co,2) = sizeTargetIM_Y - data(co,2);          %y
    c(co,3) = data(co,3);                           %theta
    c(co,4) = 177;                                  %size
    c(co,5) = 81;                                   %size
    c(co,6) = data(co,7);                           %flavour
    
    if c(co,6) > 0                                  %top or bottom
        c(co,7) = 1;
    else
        c(co,7) = 0;
    end
    
    c(co,8) = data(co,6);                           %reach
   
    if c(co,8) == 1                                 %pick
        c(co,9) = 1;
    else
        c(co,9) = 0;
    end
    
    
    end
end

% % show figure

imshow(im); hold on;
plot (data(:,1),data(:,2) ,'r*');
hold on;

dat=1;
while data(dat,1) ~= 0 || dat ==30
hold on
plot([data(dat,1),data(dat,8)],[data(dat,2),data(dat,9)],'Color','red','LineWidth',2)
dat=dat+1;
end  
hold off




