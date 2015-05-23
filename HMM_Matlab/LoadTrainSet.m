function [ trainingSet ] = LoadTrainSet(path, featuresToExtract)
    % LoadTrainSet
    %   loadTrainSet() loads the training set and prepares it
    %
    %   Input arguments:
    %       - path: The path of the training set file (.mat file)
    %       - featuresToExtract: a vector containing the features to extract (Time x Features)
    %
    %   Returns:
    %       - A training set ordered by class
    %          - trainingSet.class(i) contains all the occurences of a
    %          specific class
    %          - trainingSet.class(i).occurence(i).feature contains the
    %          selected features for a specific occurence (Features x Time) 

    disp('--- Starting the loading of the Trainset ---');
    loadedSet = load(path);
    loadedSet = loadedSet.Dataset;
    
    for i=1:11
        trainingSet.occurenceCount(i) = 0;
    end

    for i=1:size(loadedSet.Data.occurence,1)
        currentLabel = loadedSet.Data.occurence(i).label+1; %the classes range is [0-10] but matlab only accepts [1-11] (so we need to handle that)
        currentOccurence = trainingSet.occurenceCount(currentLabel) + 1; %increase the current occurence of the gesture
        %In the following line we do the feature extraction and transpose the matrix as HMM require F x T and the current matrix is given as T x F (T is time and F is feature(s))
        features = loadedSet.Data.occurence(i).sensor(1).observation(:,featuresToExtract);
        trainingSet.class(currentLabel).occurence(currentOccurence).features = features';
        trainingSet.occurenceCount(currentLabel) = currentOccurence; %update the number of occurence of the gesture with currentLabel
    end
    disp('--- Finished the loading of the Trainset ---');
end