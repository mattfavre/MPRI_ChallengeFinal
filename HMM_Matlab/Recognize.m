function [ predicted ] = Recognize( model, evalSet) 
    disp('--- Starting Recognition ---');
    % --- Initialize variables -----------------------------------
    predicted = zeros(size(evalSet.occurence,2),1);
    
    % --- Load and init the algorithm using the model -----------------------------------
    % No model is used in this dummy example
    
    % --- Iterate through all Testset and foreach occurence, predict its class -----------------------------------
    % --- Note that in our scheme, Matlab works with classes labeled from 1 to 11 (and not 0 to 10 as in the dataset)
    for i=1:size(evalSet.occurence,2)
        randomNumber = randi([1 11]); %Predict a class randomly
        predicted(i) = randomNumber;
    end
    disp('--- Finished Recognition ---');
end