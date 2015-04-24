% Plotting the chocolate positions
% Input:    im  - the snapshot from the table camera
% Output:   Data- all of the status of each chocolates with the same
%                   structure as in assignment 1.

function Data = detect(im)

    % Variables initialisation    
    Data=[];
    counter = 0;
    count=0;
    k=0;
    n=1;
    foundchoc =0;
    image2=(im);

    Img = rgb2gray(image2);
    I2= Img;
    I2(1:82,:,:) = 255;
    [findd]=[0 1 1 1 1];
    
    foundchoc=find(findd==1);

    if length(foundchoc)<1
        n=0;
    elseif length(foundchoc)>0

        [points1, theIm, count, k ,chocname]=store_samplename(foundchoc);         
        points2 = detectSURFFeatures(I2,'MetricThreshold',50);   
    end
        [features2, valid_points2] = extractFeatures(I2, points2);
     
    
    while n==1  
        if count == k-1; 
             n=0;
        end

        %Find features and matching points   
        [features1{count}, valid_points1{count}] = ...
            extractFeatures(theIm{count}, points1{count});

        indexPairs = matchFeatures(features1{count}, features2,...
            'MatchThreshold',50);
        [pairX,~] =size(indexPairs);
           
        if pairX > 6
            matchedPoints1 = valid_points1{count}(indexPairs(:, 1), :);
            matchedPoints2 = valid_points2(indexPairs(:, 2), :);

            [tform, PP1 , ~,status] = estimateGeometricTransform(...
                matchedPoints1, matchedPoints2, 'affine');
            [PPsize,~]=size(PP1);

            if PPsize>=2 && status == 0
                boxPolygon = [1, 1;...   % top-left
                             81, 1;...   % top-right
                             81, 177;... % bottom-right
                             1, 177;...  % bottom-left
                             1, 1];    
                newPolygon = transformPointsForward(tform, boxPolygon);

                check1x = newPolygon(1,1)-newPolygon(2,1); %top
                check1y = newPolygon(1,2)-newPolygon(2,2);
                check1  = sqrt(check1x^2 + check1y^2);

                check2x = newPolygon(1,1)-newPolygon(4,1); %length
                check2y = newPolygon(1,2)-newPolygon(4,2);
                check2 = sqrt( check2x^2 + check2y^2);

                check3x = newPolygon(1,1)-newPolygon(3,1); %diagonal
                check3y = newPolygon(1,2)-newPolygon(3,2);
                check3 = sqrt( check3x^2 + check3y^2);

                check4x = newPolygon(2,1)-newPolygon(4,1); %diagonal
                check4y = newPolygon(2,2)-newPolygon(4,2);
                check4  = sqrt(check4x^2 + check4y^2);

                % Check if the detected chocolate is in scale
                if ((check1 < (81 +25) && check1 > (81-25)) ...
                 &&(check2 < (177 +25)&& check2 > (177-25)) ...
                 &&(check3 < (195+30)&& check3 > (195-30))...
                 &&(check4 < (195+30)&& check4 > (195-30)))
             
                    % Get the centroid 
                    XCent = mean(newPolygon(1:end-1,1)); %Centroid x
                    YCent = mean(newPolygon(1:end-1,2)); %centroid y
                    theta1 =-atan2(newPolygon(2,2)-newPolygon(1,2),newPolygon(1,1)-newPolygon(2,1))-pi/2;
                    theta =mod(theta1+pi, 2*pi)-pi;
                    yesno = reachable(XCent,YCent);
                    % Store the values
                    counter = counter +1;

                    Data(counter,1)= 1600-XCent;
                    Data(counter,2)= YCent;
                    Data(counter,3)= -theta;
                    Data(counter,4)= 177;
                    Data(counter,5)= 81;
                    
                    % Falvour of each chocolates based on the sequence
                    %   of their respective reference image
                    if (chocname{count}(1:4)=='none');
                         Data(counter,6)= 0;
                    elseif (chocname{count}(1:4)=='milk');
                         Data(counter,6)= 1;
                    elseif (chocname{count}(1:4)=='dark');
                         Data(counter,6)= 2;
                    elseif (chocname{count}(1:4)=='oran');
                         Data(counter,6)= 3;
                    elseif (chocname{count}(1:4)=='mint');
                         Data(counter,6)= 4;
                    end

                     if (Data(counter,6)== 0)
                         Data(counter,7) = 0;
                     else
                         Data(counter,7) = 1;
                     end
                     
                         Data(counter,8) = 1;
                         Data(counter,9) = 1;
                         
                         maskchoc = poly2mask(double(newPolygon(:, 1)),double(newPolygon(:, 2)),900,1600);
                         masktable = I2;
                         masktable ( maskchoc==1)=0;
                         I2 = masktable;
                         [features2, valid_points2] = extractFeatures(I2, points2);

                         count =1;
                else
                     count = count +1;
                end
           else
                count =count +1;
           end

        else
           count = count +1; 
        end
    end
    
    % Plotting the center of the chocolates
    imshow(im); hold on;
    plot((XCent(:)),(900-YCent(:)),'ro');

    end

 
       
