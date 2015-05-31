

function [FeaStorage,MilkFeatures,Samplegray,endpoint,seperator ] = featureReader(vldMatrice)

%initialize

FeaStorage = cell(30,1);
startpoint =1 ;
endpoint = 0;
seperator = zeros(5,2);
[locationY] = find(vldMatrice == 1);
[~,sizelocY] = size(locationY);
    
    for i= 1:sizelocY
    
        if locationY(i) == 1
                        %mint
%           srcFiles = dir('student_submissions\z3402188_MTRN4230_ASST1\Mint\*.jpg');
            srcFiles = dir('Mint\*.jpg');
            MaxNum= length(srcFiles);
            
            %prevent overlap and store to array
            endpoint = endpoint +MaxNum;
            Threshold = 370;
            [FeaStoragepieces,MilkFeat,Sample] = ImageServer(MaxNum,5,Threshold);
            FeaStorage(startpoint : endpoint) = FeaStoragepieces(1 : MaxNum);
            Samplegray(startpoint : endpoint) = Sample(1 : MaxNum);
            MilkFeatures(startpoint : endpoint) = MilkFeat(1 : MaxNum);
            
            %store to array to be use in main func later
            seperator(i,1) = endpoint;
            seperator(i,2) = locationY(i);
            seperator(i,3) = 4;
            startpoint =  endpoint+1;
%             
        elseif locationY(i) == 2
            %blue
%             srcFiles = dir('student_submissions\z3402188_MTRN4230_ASST1\Milk\*.jpg');
            srcFiles = dir('Milk\*.jpg');
            MaxNum= length(srcFiles);
            
            %prevent overlap and store to array
            endpoint = endpoint +MaxNum;
            Threshold = 370;
            [FeaStoragepieces,MilkFeat,Sample] = ImageServer(MaxNum,2,Threshold);
            Samplegray(startpoint : endpoint) = Sample(1 : MaxNum);
            FeaStorage(startpoint : endpoint) = FeaStoragepieces(1 : MaxNum);
            MilkFeatures(startpoint : endpoint) = MilkFeat(1 : MaxNum);
            
            %store to array to be use in main func later
            seperator(i,1) = endpoint;
            seperator(i,2) = locationY(i);
            seperator(i,3) = 1;
            startpoint =  endpoint+1;
            
        elseif locationY(i) == 3
            %orange
%             srcFiles = dir('student_submissions\z3402188_MTRN4230_ASST1\Orange\*.jpg');
            srcFiles = dir('Orange\*.jpg');
            MaxNum= length(srcFiles);
            
            %prevent overlap and store to array
            endpoint = endpoint +MaxNum;
            Threshold = 370;
            [FeaStoragepieces,MilkFeat,Sample] = ImageServer(MaxNum,3,Threshold);
            FeaStorage(startpoint : endpoint) = FeaStoragepieces(1 : MaxNum);
            Samplegray(startpoint : endpoint) = Sample(1 : MaxNum);
            MilkFeatures(startpoint : endpoint) = MilkFeat(1 : MaxNum);
            
            %store to array to be use in main func later
            seperator(i,1) = endpoint;
            seperator(i,2) = locationY(i);
            seperator(i,3) = 3;
            startpoint =  endpoint+1;
            
        elseif locationY(i) == 4
            %dark
%             srcFiles = dir('student_submissions\z3402188_MTRN4230_ASST1\Dark\*.jpg');
            srcFiles = dir('Dark\*.jpg');
            MaxNum=length(srcFiles);
            
            %prevent overlap and store to array
            endpoint = endpoint +MaxNum;
            Threshold = 370;
            [FeaStoragepieces,MilkFeat,Sample] = ImageServer(MaxNum,4,Threshold);
            FeaStorage(startpoint: endpoint) = FeaStoragepieces(1 : MaxNum);
            Samplegray(startpoint : endpoint) = Sample(1 : MaxNum);
            MilkFeatures(startpoint : endpoint) = MilkFeat(1 : MaxNum);
            
            %store to array to be use in main func later
            seperator(i,1) = endpoint;
            seperator(i,2) = locationY(i);
            seperator(i,3) = 2;
            startpoint =  endpoint+1;
            
        elseif locationY(i) == 5
            
            %unknown
%             srcFiles = dir('student_submissions\z3402188_MTRN4230_ASST1\Unknown\*.jpg');
            srcFiles = dir('Unknown\*.jpg');
            MaxNum= length(srcFiles);
            
            %prevent overlap and store to array
            endpoint = endpoint +MaxNum;
            Threshold = 100;
            [FeaStoragepieces,MilkFeat,Sample] = ImageServer(MaxNum,1,Threshold);
            Samplegray(startpoint : endpoint) = Sample(1 : MaxNum);
            FeaStorage(startpoint : endpoint) = FeaStoragepieces(1 : MaxNum);
            MilkFeatures(startpoint : endpoint) = MilkFeat(1 : MaxNum);
            
            %store to array to be use in main func later
            seperator(i,1) = endpoint;
            seperator(i,2) = locationY(i);
            seperator(i,3) = 0; 
            startpoint =  endpoint+1;
        
        end
        
        
    end
end
    
    
    
    
    
function  [FeaStorage,MilkFeatures,Samplegray] = ImageServer(MaxNum,ImageMode,Threshold)

%initialize
FeaStorage= cell(MaxNum,1);
Samplegray= cell(MaxNum,1);
MilkFeatures= cell(1,MaxNum);

    %change the path according to choc flavour
    if ImageMode == 1
        Astr = 'Unknown.jpg';
%         Fold = 'student_submissions\z3402188_MTRN4230_ASST1\Unknown\';
         Fold = 'Unknown\';
    elseif ImageMode == 2
        Astr = 'Milk.jpg';
%         Fold = 'student_submissions\z3402188_MTRN4230_ASST1\Milk\';
        Fold = 'Milk\';
    elseif ImageMode == 4
        Astr = 'Dark.jpg';
%         Fold = 'student_submissions\z3402188_MTRN4230_ASST1\Dark\';
         Fold = 'Dark\';
    elseif ImageMode == 3
        Astr = 'Orange.jpg';
%         Fold = 'student_submissions\z3402188_MTRN4230_ASST1\Orange\';
        Fold = 'Orange\';
    elseif ImageMode == 5
        Astr = 'Mint.jpg';
%         Fold = 'student_submissions\z3402188_MTRN4230_ASST1\Mint\';
          Fold = 'Mint\';
        
    end
    
    parfor j=1:MaxNum
        
        %change interger to string and read
        str = int2str(j);
        sample = imread(strcat(Fold,str,Astr));
        
        %convert and store features in array
        sampleready = rgb2gray(sample);
        Samplegray{j} = sampleready;
        chocPoints = detectSURFFeatures(Samplegray{j},'MetricThreshold',Threshold);
        FeaStorage{j} = chocPoints;
        [MilkFeatures{j}, FeaStorage{j}] = extractFeatures(Samplegray{j}, FeaStorage{j});

    end
   
end
    
