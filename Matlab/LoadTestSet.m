function [ testSet ] = LoadTestSet( path, featuresToExtract)

    % LoadTestSet
    %   LoadTestSet() loads the test set and preparse it
    %
    %   Input arguments:
    %       - path: The path of the evaluation set file (.mat file)
    %       - featuresToExtract: a vector containing the features to extract
    %
    %   Returns:
    %       - An evaluation set
    %          - trainingSet.occurence(i).feature contains the selected features for a specific occurence (Time x Feature)

    disp('--- Starting the loading of the Testset ---');
    loadedSet = load(path);
    loadedSet = loadedSet.Dataset;

    for i=1:size(loadedSet.Data.occurence,1)
        %In the following line we do the feature extraction and transpose
        %the matrix as HMM require F x T and the current matric is given as
        %T x F (T is time and F is feature(s))
        features = loadedSet.Data.occurence(i).sensor(1).observation(:,featuresToExtract);
        testSet.occurence(i).features = features';
    end
    disp('--- Finished the loading of the Testset ---');
end