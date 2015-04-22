function [findd ] = typesofchoc(image2)

findd = zeros(1,5);
flavour=1;
non= imread('aNONE.jpg');
image_3= (imabsdiff(image2,non));
 image3 = imcomplement(image_3);
 Hsv = rgb2hsv(image_3);
%  figure(3);imshow(Hsv)
while flavour <=5
%         if flavour == 0 %unknown
%             colour =((Hsv(83:end,:,1)>=0.490 & Hsv(83:end,:,1) <=0.721)...
%                     &(Hsv(83:end,:,2)>=0.203&Hsv(83:end,:,2)<=1)...
%                     &(Hsv(83:end,:,3)>=0.00&Hsv(83:end,:,3)<=0.598));
%         if flavour == 0 %unknown
%             colour =((Hsv(83:end,:,1)>=0.2 & Hsv(83:end,:,1) <=0.161)...
%                     &(Hsv(83:end,:,2)>=0.498&Hsv(83:end,:,2)<=1)...
%                     &(Hsv(83:end,:,3)>=0.142&Hsv(83:end,:,3)<=0.561));

    if flavour == 1 %milk/blue
        colour =((Hsv(83:end,:,1)>=0.490 & Hsv(83:end,:,1) <=0.791)...
                &(Hsv(83:end,:,2)>=0.332&Hsv(83:end,:,2)<=1)...
                &(Hsv(83:end,:,3)>=0.220&Hsv(83:end,:,3)<=0.858));
            if find(colour==1)>0
                findd(flavour)=1;
                flavour=flavour+1 ;
%             else
%                 colour1 =colour;
%                 colour1 = bwareaopen(colour1,100);
% 
%                 colour1 = bwmorph(colour1,'open');
%                 colour1 = bwconvhull(colour1,'Object' );
% %                 imshow(colour1)
%                 [label,~] = bwlabel(colour1); 
%                 area = regionprops(label ,'Area');   
%                 area1= struct2cell(area);
%                  area2 = cell2mat(area1);
%                  
%                  search = find(area2<5000 & area2> 1300);
%                 search1 = find(area2<1000 & area2>900);
%                 if  size(search) ~= 0
%                     findd(flavour) = 1;
%                     flavour=flavour+1 ;
%                 end
%                 if size(search1) ~= 0
%                     findd(flavour)=1;
%                     flavour=flavour+1 ;
%                 end
            else
          flavour=flavour+1 ;
            end

    elseif flavour == 2 %dark
               colour =((Hsv(83:end,:,1)>=0.192 & Hsv(83:end,:,1)<=0.958)...
                        &(Hsv(83:end,:,2)>=0&Hsv(83:end,:,2)<=0.376)...
                        &(Hsv(83:end,:,3)>=0.408&Hsv(83:end,:,3)<=0.502));
%        colour =((Hsv(83:end,:,1)*360>0 & Hsv(83:end,:,1)*360<63)...
%                 &(Hsv(83:end,:,2)>0&Hsv(83:end,:,2)<0.2)...
%                 &(Hsv(83:end,:,3)>=0.0&Hsv(83:end,:,3)<=0.8));
%                 colour1 =colour;
%                 colour1 = bwareaopen(colour1,100);
%                 colour1 = bwmorph(colour1,'open');
%                 colour1 = bwconvhull(colour1,'Object' );
%                 [label,~] = bwlabel(colour1); 
%                 area = regionprops(label ,'Area');   
%                 area1= struct2cell(area);
%                 area2 = cell2mat(area1);
%                 
%                 search = find(area2<900 & area2> 20);
% %                 search1 =find(max(area2)>5000);
%                 if  size(search) ~= 0 
%                     findd(flavour) = 1; 
%                     flavour=flavour+1 ;
                    if find(colour==1)>0
                    findd(flavour)=1;
                    flavour=flavour+1 ;
                else
            flavour=flavour+1 ;
                end
                    
   elseif flavour == 3 %orange
               colour =((Hsv(83:end,:,1)>=0.470 & Hsv(83:end,:,1) <=0.594)...
                        &(Hsv(83:end,:,2)>=0.018 & Hsv(83:end,:,2)<=1)...
                        &(Hsv(83:end,:,3)>=0.402 & Hsv(83:end,:,3)<= 0.674));
                    if find(colour==1)>0
                    findd(flavour)=1;
                    flavour=flavour+1 ;
                    else
                     flavour= flavour +1;
                    end
        elseif flavour == 4 %mint/green
               colour =((Hsv(83:end,:,1)>=0.180 & Hsv(83:end,:,1) <=0.55)...
                        &(Hsv(83:end,:,2)>=0.272&Hsv(83:end,:,2)<=1)...
                        &(Hsv(83:end,:,3)>=0.089&Hsv(83:end,:,3)<=1));
                    if find(colour==1)>0
                    findd(flavour)=1;
                    flavour=flavour+1 ;
                    else
                     flavour= flavour +1
                    end
        elseif flavour ==5 %none
            colour =((Hsv(83:end,:,1)>=0.025 & Hsv(83:end,:,1) <=0.164)...
                        &(Hsv(83:end,:,2)>=0.374&Hsv(83:end,:,2)<=1)...
                        &(Hsv(83:end,:,3)>=0.281&Hsv(83:end,:,3)<=0.588));
            colour1 =((Hsv(83:end,:,1)>=0& Hsv(83:end,:,1) <=0.958)...
                &(Hsv(83:end,:,2)>=0&Hsv(83:end,:,2)<=0.276)...
                &(Hsv(83:end,:,3)>=0.153&Hsv(83:end,:,3)<=0.584));
                    if find(colour==1)>0
                    findd(flavour)=1;
                    flavour=flavour+1 ;
                   
                    elseif  find(colour1==1)>0
                    findd(flavour)=1;
                    flavour=flavour+1 ;
                    else
                        findd(flavour)=0;
                        flavour= flavour +1;
                    end
            
    end
        
  end
    

