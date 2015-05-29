%% Group 10 - The Power Rangers                                 
% This is a function to detect the chocolates status 
% [X Y orientation width length flavour 'up or down' pickability reachability]
% 
% Original version was created for assignment 1 MTRN4230
% Senior GUI Engineers, The Power Ranger, UNSW
% 
%% Load reference image
function c = findChoc(chocImage)
imshow(imread(chocImage));    
hold on;
        c   = [];
    found   = 0;
    count = 1;
    %% Load all files containing the variables
    load('referencImages.mat'); 

    %% Image processing    
    img.image.rgb   = imread(chocImage); 
    img.image.clean= img.image.rgb;
    img.image.clean(1:81,:) = 255;  

    img.image.gray  = rgb2gray(img.image.clean);
    temp = size(img.image.gray);
    img.res = temp(1:2);
    
    %% Compute surf features of the image
    img.SURFd   = detectSURFFeatures( img.image.gray, 'MetricThreshold',1000);
    [img.SURFf, img.SURFp]   = extractFeatures( img.image.gray, img.SURFd);    
    
    %% Comparing the features of the image with the features of the 
    %   reference images
    for flavi = 1:5
        tempStruct = refChoc{flavi};
        for refi = 1:tempStruct.N
            refUsed = tempStruct.ref{refi};
            detect = 1;
        %keep using the same reference if it did detect any chocolate
            while detect == 1
                % Retrieve the locations of matched points.
                indexPairs = matchFeatures(img.SURFf, refUsed.SURFf,'unique',1);
                img.matchedPoints   = img.SURFp(indexPairs(:, 1));
                refUsed.matchedPoints   = refUsed.SURFp(indexPairs(:, 2));
                detect = 0;

                if img.matchedPoints.Count > 3 %&& ab<20 && ab>20

                    % find the pose and orientation of the chocolate using
                    % transformation from the reference chocolate
                    [tform, ~, ~, ~]   = estimateGeometricTransform( ...
                        refUsed.matchedPoints , img.matchedPoints, 'affine');
                    Center = [ refUsed.res(2)/2, refUsed.res(1)/2];% center of chocolate
                    newCenter = transformPointsForward(tform, Center);
                    Tinv  = tform.invert.T;
                    ss = Tinv(2,1);
                    sc = Tinv(1,1);
                    scaleRecovered = sqrt(ss*ss + sc*sc);
                    thetaRecovered = atan2(ss,sc);

                    % if the size the mathcing features about the same
                    if  scaleRecovered<1.03 && scaleRecovered>0.97

                        %Removing the feature points that had already detected
                        %as a part of the chocolate
                        X   = newCenter(1);
                        Y   = newCenter(2);   
                        theta   = thetaRecovered;
                        cosT    = cos(theta);
                        sinT    = sin(theta);
                        rec = [cosT, -sinT; sinT, cosT]*[ 92, 92, -92,...
                            -92, +92 ; 44, -44, -44, 44, 44]...
                            +[X X X X X; Y Y Y Y Y]; 
                        plot(rec(1,:),rec(2,:),'g');
                        %plot(X,Y,'ro');
                        
                        box{count} = rec;
                        count = count +1; 
                        
                        xq  = img.SURFp.Location(:,1);
                        yq  = img.SURFp.Location(:,2);
                        xv  = rec(1,:)';
                        yv  = rec(2,:)';
                        in  = inpolygon(xq,yq,xv,yv);
                        img.SURFf(in, :)=[];
                        img.SURFp(in)=[];                   
                        detect = 1;

                        % checking pickability == reachability
                        if (((X-800)^2)/(800^2) + ((Y-143)^2)/(570^2)) <=1
                            reach = 1;
                        else 
                            reach = 0;
                        end
                        pick = reach;
                        found = found+1;

                        % pose in assgnment's axis    
                        %X = img.res(2)-X;

                        % calculating the angle for the new axis
                        theta = mod(-theta+pi,2*pi);
                        
                        if flavi==5
                            topBtm = 0;
                        else
                            topBtm = 1;
                        end

                       switch flavi
                           case 1
                               Realflavi=4;
                           case 2
                               Realflavi=3;
                           case 3
                               Realflavi=2;
                           case 4
                               Realflavi=1;
                           otherwise
                               Realflavi=0;
                       end
                        c(found,:)  = [X, Y, theta,...
                            177, 81, Realflavi, topBtm, reach, pick ];
                        plot(X,Y,'ro');
                    end                                
                end            
            end
        end
    end
    hold off;
   
 return 