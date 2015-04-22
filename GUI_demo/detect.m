
% MTRN4230_Assignment_1_Auto_Mark('./training_set/','./student_submissions/','./student_results/','./training_labels/','./student_marks/',600)
 function Data = detect(im)
%  Rx= 900/2;
%  Ry = 720;
%  reachableY = image3(:,142:800);
 

% variable
    Data=[];
    counter = 0;
    count=0;
    k=0;
    n=1;
    foundchoc =0;
    % Data = zeros(20,9);

    % num = numberofsample*typesofchoc;
    %take in image
    image2=(im);
%      image2 = imread('IMG_007.jpg');
    %  non= imread('aNONE.jpg');
    %    image_3= (imabsdiff(image2,non));
    %   image3 = imcomplement(image_3);
    Img = rgb2gray(image2);
    I2= Img;
    I2(1:82,:,:) = 255;
%     [findd] = typesofchoc(image2);
[findd]=[0 1 1 1 1];
    foundchoc=find(findd==1);

    if length(foundchoc)<1
        n=0;
    elseif length(foundchoc)>0
        %save feature in array form
        [points1, theIm, count, k ,chocname]=store_samplename(foundchoc);         
        points2 = detectSURFFeatures(I2,'MetricThreshold',50);   
        end
        [features2, valid_points2] = extractFeatures(I2, points2);
     
    
    while n==1  
        if count == k-1; 
             n=0;
        end

        %Find features and matching points   
        [features1{count}, valid_points1{count}] = extractFeatures(theIm{count}, points1{count});

        indexPairs = matchFeatures(features1{count}, features2,'MatchThreshold',50);
        [pairX,~] =size(indexPairs);
           
            if pairX > 6
            matchedPoints1 = valid_points1{count}(indexPairs(:, 1), :);
            matchedPoints2 = valid_points2(indexPairs(:, 2), :);
%             figure(1);
%             showMatchedFeatures(theIm{count},I2, matchedPoints1, matchedPoints2,'montage');
    %         %get coodinates
            [tform, PP1 , ~,status] = estimateGeometricTransform(matchedPoints1, matchedPoints2, 'affine');
            [PPsize,~]=size(PP1);

            if PPsize>=2 && status == 0
    %         boxPolygon = [1, 1;...                     % top-left
    %                 size(theIm{count}, 2), 1;...                 % top-right
    %                 size(theIm{count}, 2), size(theIm{count}, 1);... % bottom-right
    %                 1, size(theIm{count}, 1);...           % bottom-left
    %                 1, 1];                   % top-left again to close the polygon
                boxPolygon = [1, 1;...                     % top-left
                             81, 1;...                 % top-right
                             81, 177;... % bottom-right
                             1, 177;...           % bottom-left
                             1, 1];    
                newPolygon = transformPointsForward(tform, boxPolygon);
    %
    %         % Threshold of the shape bounding the chocolate
    %             if check2<(177+30) && check2>(177-30) ... %length
    %                     && check6<(177+35) && check6>(177-35) ...
    %                     && check1<(81+35) && check1>(81-35) ...
    %                     && check5<(81+35) && check5>(81-35) ...
    %                     && check3<(194+35) && check3>(194-35) ...
    %                     && check4<(194+35) && check4>(194-35)
    %                     yes=1;
    %                     %draw box on detected chocolate
    % %                     figure(4);imshow(image2); hold on; 
    % %                     plot(newPolygon(:, 1), newPolygon(:, 2), 'Color', 'b');
    % %                     title('Detected Box');
    %                     
    %                     counter = counter +1;
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


                if ((check1 < (81 +25) && check1 > (81-25)) ...
                 &&(check2 < (177 +25)&& check2 > (177-25)) ...
                 &&(check3 < (195+30)&& check3 > (195-30))...
                 &&(check4 < (195+30)&& check4 > (195-30)))
                    %get centroid
                    
                    XCent = mean(newPolygon(1:end-1,1)); %Centroid x
                    YCent = mean(newPolygon(1:end-1,2)); %centroid y
                    theta1 =-atan2(newPolygon(2,2)-newPolygon(1,2),newPolygon(1,1)-newPolygon(2,1))-pi/2;
                    theta =mod(theta1+pi, 2*pi)-pi;
                    yesno = reachable(XCent,YCent);
                    %store the values
                    counter = counter +1;

                    Data(counter,1)= 1600-XCent;
                    Data(counter,2)= YCent;
                    Data(counter,3)= -theta;
                    Data(counter,4)= 177;
                    Data(counter,5)= 81;
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
                     
%                      if yesno==1
%                          Data(counter,8) = 1;
%                      else
%                          Data(counter,8) = 0;
%                      end
                         Data(counter,8) = 1;
                         Data(counter,9) = 1;
                         
                        %delect found chocolate to move on to next
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
    
% %         if i>length(choc)
% %             break;
% %         end
%         cT = cos(choc(i).Orientation/180*pi);
%         sT = sin(choc(i).Orientation/180*pi);   
%         xs = [41, 41, -41, -41, 41];
%         ys = [89, -89, -89, 89, 89];
%         rec = [cT , sT; -sT, cT]*[xs;ys]+...
%             [choc(i).Centroid' choc(i).Centroid' choc(i).Centroid' choc(i).Centroid' choc(i).Centroid'];
        imshow(im); hold on;
        hold on;
        plot((XCent(:)),(900-YCent(:)),'ro');
        
%         plot(rec(1,:),rec(2,:),'g');
     
    %     p = (XCent(:));
    %     plotY = (YCent(:));

    %     figure(2);
    %     imshow(image2);
    %     hold on; title('Detected Box')
    %     plot(,'ro');
    %     hold on;
    %   end
    end

 
       
