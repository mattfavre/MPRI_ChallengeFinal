function [ predicted ] = Test(testset_path) 
    FeaturesToExtract = [1:9 18:29];
    %load('myModel.mat', 'model'); this dummy example does not use a model
    model = [];
    testSet = LoadTestSet(testset_path,FeaturesToExtract); %in this function, when the dataset is loaded, the labels are converted from 0 to 10 to 1 to 11 for matlab
    predicted = Recognize(model, testSet);
    predicted = int32(predicted)-1; %this is very important (in the original dataset, classes are labelled from 0 to 10 and not from 1 to 11)
    filename = 'results.txt';
    fid = fopen(filename, 'w');
    dlmwrite(filename,predicted,'-append',... 
     'delimiter',' ',...
     'newline','pc');
    fclose(fid);
end