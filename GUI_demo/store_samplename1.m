function [points1, theIm,count, k, chocname]=store_samplename(foundchoc,program_folder)


k=1; %number of choc
count=1;
    if foundchoc == 1
     file_name=  load (program_folder,'milk.mat');
    %     for g= 1:typesofchoc
    %         for i= 1:numberofsample
    % %             tyyp(k)=foundchoc(c);
    %             chocname{k}=strcat(milk,int2str(i));
    %             file_nam = (strcat(Name{foundchoc(g)-1},int2str(i),'.jpg'));
    %             file_name= imread(strcat(program_folder,file_num));
    %             %change to gray scale   
               I1 = rgb2gray(file_name);
                theIm{k}=I1;           
                %store sample in array of k
                points1{k} = detectSURFFeatures(theIm{count},'MetricThreshold',150);
                 k=k+1;

    elseif foundchoc == 2
      file_name=  load (program_folder,'dark.mat');
               I1 = rgb2gray(file_name);
                theIm{k}=I1;           
                %store sample in array of k
                points1{k} = detectSURFFeatures(theIm{count},'MetricThreshold',150);
                 k=k+1;
                 
    elseif foundchoc == 3
      file_name=  load (program_folder,'orange.mat');
               I1 = rgb2gray(file_name);
                theIm{k}=I1;           
                %store sample in array of k
                points1{k} = detectSURFFeatures(theIm{count},'MetricThreshold',150);
                 k=k+1;

    elseif foundchoc == 4
      file_name=  load (program_folder,'mint.mat');
               I1 = rgb2gray(file_name);
                theIm{k}=I1;           
                %store sample in array of k
                points1{k} = detectSURFFeatures(theIm{count},'MetricThreshold',150);
                 k=k+1;

    elseif foundchoc == 1
      file_name=  load (program_folder,'none.mat');
               I1 = rgb2gray(file_name);
                theIm{k}=I1;           
                %store sample in array of k
                points1{k} = detectSURFFeatures(theIm{count},'MetricThreshold',150);
                 k=k+1;

    end
    end
%    
   
   