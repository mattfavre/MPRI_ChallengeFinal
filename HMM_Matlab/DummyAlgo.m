% -----------------------------
% Opegra - Dummy algorithm
% Author    : Simon Ruffieux
% -----------------------------

%clear all variables
clearvars; 
clc;

% --- /!\ CONSTANT /!\ --- 
PATH_TRAINSET_FILE      = 'C:\Users\Matthieu\Documents\MSE\Semestre4\02_MPRI\Git\MPRI_ChallengeFinal\HMM_Matlab\DataSet\Dataset_segmented.mat'; %the path to the dataset
PATH_TESTSET_FILE      = 'C:\Users\Matthieu\Documents\MSE\Semestre4\02_MPRI\Git\MPRI_ChallengeFinal\HMM_Matlab\DataSet\Dataset_segmented.mat'; %for testing purposes only (Normally you should split your Trainset (cross-validation, etc))

% --- /!\ OPTIONS /!\ --- 
% Choose according to what you want to do
LOAD_DATASET       = 1; % 0: No, 1: Yes
TRAIN           = 1; % 0: No, 1: Yes
RECOGNIZE       = 1; % 0: No, 1: Yes

PARAMETERS = [];

%Features to be extracted from the xsens sensor
FeaturesToExtract =    [(1*17+7):(1*17+9) (1*17+14):(1*17+17)
                        (2*17+7):(2*17+9) (2*17+14):(2*17+17)
                        (3*17+7):(3*17+9) (3*17+14):(3*17+17)]; %Select which features to extract

% --- LOAD TRAIN SET ORDERED BY CLASSES --------------------------%
if LOAD_DATASET == 1
    classSet = LoadTrainSet(PATH_TRAINSET_FILE,FeaturesToExtract);
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
    evalSet = LoadTestSet(PATH_TESTSET_FILE,FeaturesToExtract);
    % --- Start recognition --------------------------%
    predicted = Recognize(model, evalSet);
    predicted = int32(predicted)-1;
    % --- Output results in file --------------------------%
    filename = 'results.txt';
    fid = fopen(filename, 'w');
    dlmwrite(filename,predicted,'-append',...  %# Print the matrix
     'delimiter',' ',...
     'newline','pc');
    fclose(fid);
end






