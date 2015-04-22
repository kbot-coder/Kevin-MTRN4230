function [points1, theIm,count, k, chocname, g]=store_samplename(foundchoc)

%loop through name of file
Name= { 'milk', 'dark', 'orange', 'mint', 'none'};
numberofsample =40; 
typesofchoc =length(foundchoc);
k=1; %number of choc
% type1 = 
count=1;
 theIm=[];
  points1=[];
% Name{foundchoc};
    for g= 1:typesofchoc
        for i= 1:numberofsample
%             tyyp(k)=foundchoc(c);
            chocname{k}=strcat(Name{foundchoc(g)},int2str(i));
%             name =(Name{foundchoc(g)-1},int2str(i))
            file_name = imread(strcat('student_submissions\z3330656_MTRN4230_ASST1\',Name{foundchoc(g)},int2str(i),'.jpg'));
%file_name = imread(strcat(Name{foundchoc(g)},int2str(i),'.jpg'));            
%change to gray scale   
           I1 = rgb2gray(file_name);
            theIm{k}=I1;           
            %store sample in array of k
            if foundchoc(g)==5
                points1{k} = detectSURFFeatures(theIm{count},'MetricThreshold',50);
                k=k+1;
            else
                points1{k} = detectSURFFeatures(theIm{count},'MetricThreshold',50);
                k=k+1;
            end
        end
    end
   