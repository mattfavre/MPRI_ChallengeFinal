% -----------------------------
% Opegra - Dummy algorithm
% Author    : Simon Ruffieux
% -----------------------------

%clear all variables
clearvars; 
clc;

% --- /!\ CONSTANT /!\ --- 
PATH_TRAINSET_FILE      = './DataSet/Dataset_segmented.mat'; %the path to the dataset
PATH_TESTSET_FILE      = './DataSet/Dataset_segmented.mat'; %for testing purposes only (Normally you should split your Trainset (cross-validation, etc))

% --- /!\ OPTIONS /!\ --- 
% Choose according to what you want to do
LOAD_DATASET       = 1; % 0: No, 1: Yes
TRAIN           = 0; % 0: No, 1: Yes
RECOGNIZE       = 0; % 0: No, 1: Yes

PARAMETERS = [];

%Features to be extracted from the xsens sensor. 
% We are going to use Hand : 
%			Yaw, roll, pitch, 
%		      
%                     WristLeft:
%			QuatX,QuatY,QuatZ			
%		      
%		      Elbow :
%			QuatX,QuatY,QuatZ
%
% 
% We are going to use ElbowLeft WristLeft ElbowRight WristRight HandRight

%FeaturesToExtractXSens = [17*3+7:17*3+9 17*2+14:17*2+16 17*1+14:17*1+16]; %Select which features to extract
FeaturesToExtractXSens = [17*3+7:17*3+9 17*3+14:17*3+16]; %Select which features to extract

% --- LOAD TRAIN SET ORDERED BY CLASSES --------------------------%
if LOAD_DATASET == 1
    classSet = LoadTrainSet(PATH_TRAINSET_FILE,FeaturesToExtractXSens);
    disp('--- Number of occurence per class in the loaded training set: ---');
    classSet.occurenceCount
end

% --- TRAIN THE MODEL FOR THE ALGORITHM --------------------------%
if TRAIN == 1
    model = TrainModel(classSet, PARAMETERS);   
    save('myModel.mat', 'model'); %save model
    disp('--- Saved the model ! (File: myModel.mat) ---');
end

% --- RECOGNIZE CLASSES IN EVALUATION SET ----------------------------
if RECOGNIZE == 1
    % --- Load Model --------------------------%
    load('myModel.mat', 'model');
    disp('--- Loaded the model ! (File: myModel.mat) ---');
    % --- Load Evaluation set --------------------------%
    evalSet = LoadTestSet(PATH_TESTSET_FILE,FeaturesToExtractXSens);
    % --- Start recognition --------------------------%
    predicted = Recognize(model, evalSet);
    
    figure;
    hist(predicted);
    title('Histogramme of gesture');
    xlabel('Gesture number');
    ylabel('Apparitions');
    predicted = int32(predicted)-1;
    
    
   
    % --- Output results in file --------------------------%
    filename = 'results.txt';
    fid = fopen(filename, 'w');
    dlmwrite(filename,predicted,'-append',...  %# Print the matrix
     'delimiter',' ',...
     'newline','pc');
    fclose(fid);
end






