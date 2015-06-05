function [model] = TrainModel(trainSet, PARAMETERS)
    % --- Training of the model fo the algorithm (strongly depends on type of algorithm) -----------------------------------
    disp('--- Starting the training of the model for the algorithm ---');
    
   % Iteration sur les classes
   training_set = [];
   training_set_tmp = [];
   target_set = [];
   
   net = feedforwardnet(45);
       
   for i=1:11
       % Iteration sur les occurences
       for j=1:trainSet.occurenceCount(i)
           target_set = [target_set ; zeros([1 11])];
           
           m = size(target_set,1);
           target_set(m,i) = 1;
           
           training_set_tmp = [];
              
           % Iteration sur les features
           for k=1:size(trainSet.class(i).occurence(j).features)
               
               % Signal processing
               sig = trainSet.class(i).occurence(j).features(k,:);
               
               %plot(sig);
               
               training_set_tmp = [training_set_tmp, sig];   
           end
          % plot([1:128],training_set_tmp(1:128),[1:128],training_set_tmp(129:256),[1:128],training_set_tmp(257:384));
           training_set = [training_set;training_set_tmp]   ;     
       end
   end  

%    net.trainFcn = 'trainscg'
%    net.performFcn = 'crossentropy';
%    net.divideParam.trainRatio = 0.7;
%    net.divideParam.valRatio = 0.2;
%    net.divideParam.testRatio = 0.1;
    
   %net = configure(net,training_set',target_set');
   net = train(net,training_set',target_set');
   
   simpleclassOutputs = sim(net,training_set');
   plotconfusion(target_set',simpleclassOutputs);
   
   %view(net);

    %Do the training to generate a model
    model = net;
    disp('--- Finished the training of the model for the algorithm ---');
end