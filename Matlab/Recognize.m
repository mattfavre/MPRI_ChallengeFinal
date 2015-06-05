function [ predicted ] = Recognize( model, evalSet) 
    disp('--- Starting Recognition ---');
    
    net = model;
    lp_filter = load('filt.mat');
    
   % show(net);
    
    true_recon = 0;
    recon_num = 0;
    
    % --- Initialize variables -----------------------------------
    predicted = zeros(size(evalSet.occurence,2),1);
    
    % --- Load and init the algorithm using the model -----------------------------------
    % No model is used in this dummy example
    
    % --- Iterate through all Testset and foreach occurence, predict its class -----------------------------------
    % --- Note that in our scheme, Matlab works with classes labeled from 1 to 11 (and not 0 to 10 as in the dataset)
   
    targets = [];
    outputs = [];
    for i=1:size(evalSet.occurence,2)
        test_set_tmp = [] ;
        for k=1:size(evalSet.occurence(i).features,1)
                % Signal processing
               sig = evalSet.occurence(i).features(k,:);
                  
               test_set_tmp = [test_set_tmp, sig]; 
        end
        pred = net(test_set_tmp') ;
        [dummy , ind] = max(pred);
        
        predicted(i) = ind;
        
        recon_num= recon_num +1;
        
        if evalSet.occurence(i).label == ind
            true_recon = true_recon +1 ;
        else
             disp(['Error ! Labeled = ' num2str(evalSet.occurence(i).label) ', detected = ' num2str(ind)  ]);
        end
        
%         pred = zeros([1 11]);
%         pred(ind) = 1 ;
%         tar = zeros([1 11]);
%         tar(evalSet.occurence(i).label) =  1 ;
%         
%         targets = [targets ; tar ];
%         outputs = [outputs ; pred ];
        
    end
    
    disp(['Taux de performances = ' num2str((true_recon/recon_num)*100) ' %']);
    disp('--- Finished Recognition ---');
end