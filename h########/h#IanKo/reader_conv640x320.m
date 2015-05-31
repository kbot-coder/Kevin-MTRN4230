 function [seeker] = reader_conv(targetxx)
%initialize
seeker = zeros(1,5);

%converting target image
% load('boxpics.mat','-mat')
% tableIM =snapwithoutbox;
tableIM = imread('0.jpg');

targetIM = targetxx;
targetIM = imcomplement(imabsdiff(targetIM,tableIM ));
targetHsv = rgb2hsv(targetIM);

  for countingIM = 1:5      
    %isolate colour according to flavour
    
    if countingIM == 1
        %unknown
        Selected =((targetHsv(:,:,1)*360>100 & targetHsv(:,:,1)*360 <300)...
            &(targetHsv(:,:,2)<0.4) &(targetHsv(:,:,3)>0 & targetHsv(:,:,3)<0.8));
        
    elseif countingIM == 2
        %blue
        Selected =( (targetHsv(:,:,1)*360>210 & targetHsv(:,:,1)*360 <240)...
            &(targetHsv(:,:,2)<1) &(targetHsv(:,:,3)>0.65 &targetHsv(:,:,3)<0.95));
        
    elseif countingIM == 3
        %orange
        Selected =( (targetHsv(:,:,1)*360>20 & targetHsv(:,:,1)*360 <40)...
            &(targetHsv(:,:,2)>0.05) &(targetHsv(:,:,3)>0.8 &targetHsv(:,:,3)<1));
        
    elseif countingIM == 4
        %dark
        Selected =( (targetHsv(:,:,1)*360>0 & targetHsv(:,:,1)*360 <60)...
            &(targetHsv(:,:,2)<0.2 & targetHsv(:,:,2)>0) &(targetHsv(:,:,3)>0.0 &targetHsv(:,:,3)<0.8));
        
        
    elseif countingIM == 5
        %mint
        Selected =( (targetHsv(:,:,1)*360>40 & targetHsv(:,:,1)*360 <100)...
            &(targetHsv(:,:,2)>0.2) &(targetHsv(:,:,3)>0 &targetHsv(:,:,3)<1));
        
    end
       
    
    %isolate and convert to bw
    bwSelected =Selected;
    bwSelected = bwareaopen(bwSelected,100);
    bwSelected = bwmorph(bwSelected, 'open');
    bwSelected = bwconvhull(bwSelected, 'Object' );
    [labeled,~] = bwlabel (bwSelected);
    
    %find area and calculate the value
    measurement = regionprops(labeled ,'Area');   
    measurement0 = struct2cell(measurement);
    measurement1 = cell2mat(measurement0);

    %find the chocolate according to the area found in the bw image
    if countingIM == 1
         %unknown
         yesOrno = find(measurement1<1000 & measurement1> 500);
        
         if  size(yesOrno) ~= 0
             
             seeker(countingIM) = 1;
             
         end
         
    elseif countingIM == 2
        %milk chocolate
        yesOrno = find(measurement1<5000 & measurement1> 1300);
        %unknown blue chocolate
        yesIrno = find(measurement1<1000 & measurement1>900);
        
        if  size(yesOrno) ~= 0
             
            seeker(countingIM) = 1;
             
        end
        
        if size(yesIrno) ~= 0
            
            seeker(countingIM-1)=1;
        end
        
    elseif countingIM == 3
        %Dark
        yesOrno = find(measurement1<900 & measurement1> 0);
        
        if  size(yesOrno) ~= 0
             
            seeker(countingIM) = 1;
             
        end
        
    elseif countingIM == 4
        %orange
        yesOrno = find(measurement1<900 & measurement1> 20);
        
        if  size(yesOrno) ~= 0
             
            seeker(countingIM) = 1;
             
        end
    elseif countingIM == 5
        %mint
        yesOrno = find(measurement1<1200 & measurement1> 120);
        
        if  size(yesOrno) ~= 0
             
            seeker(countingIM) = 1;
             
        end
    end
    
     
  end
    

