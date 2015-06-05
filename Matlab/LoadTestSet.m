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
    addpath('Feature Extraction'); 
    lp_filter = load('filt.mat');

    for i=1:size(loadedSet.Data.occurence,1)
        %In the following line we do the feature extraction and transpose
        %the matrix as HMM require F x T and the current matric is given as
        %T x F (T is time and F is feature(s))
        Signals = loadedSet.Data.occurence(i).sensor(1).observation(:,featuresToExtract);
        currentLabel = loadedSet.Data.occurence(i).label+1  ;
        
        % Signal pre-processing
        for j=1:size(Signals,2)         
            % Low-pass filter
            Signals(:,j) = filter(lp_filter.LP_Num,1,Signals(:,j));
        end
        
              %%% TEST %%%%%
           mel_means = [];
           mel_std = [];
           signal_features = [];

        l = size(Signals,2) ;
        for n=1:3:l
            
            % Triplet de bases
            sig_means = [mean(Signals(:,n:n+2))];
            sig_std = [std(Signals(:,n:n+2))];
            T = size(Signals(:,n:n+2),1);
            sig_energy = T * sum (Signals(:,n:n+2).^2);
            
            
            % peak-peak value
            h1 = dsp.PeakToPeak;
            pkpk_val = step(h1, Signals(:,n:n+2));
            
        
            % Signal seul
            addSigQuat = [sum(Signals(:,n:n+2),2)];
            
            % Nombre de peak et de vallée
            [maxtab, mintab] = peakdet(addSigQuat(:,1), 0.5);
            features_pkpos = size(maxtab,1);
            
            % Derivée du signal additionné
            sigDeriv  = [diff(Signals(:,n:n+2))];
            sigd_mean = mean(sigDeriv);
            sigD_energy =  T * sum (sigDeriv(:,1:3).^2);
            
            % Melcepstre test
            Fs  = 500 ;
            c = [ melcepst(addSigQuat(:,1),Fs) ];
            cd = [ melcepst(sigDeriv(:,1),Fs)];
            
            % Melcepstr energy 
            mel_energy =  T * sum (c.^2);
            
            % FFT
            NFFT = 128;
            sigfft = abs(fft(addSigQuat(:,1),NFFT));
            
            extr = sigfft(1:(NFFT/2));
            
            signal_features = [extr', signal_features, sig_means, sig_std, sig_energy, sigD_energy, pkpk_val, sigd_mean, features_pkpos];
            mel_means = [mel_means , mean(c) , mean(cd), mel_energy] ;
            mel_std = [mel_std  , std(c), std(cd)];    
   
        end
        %%% TEST %%%%% 
         
        
%         
%         % Signal features extraction
%         
%         % f1 = mean
%         features_mean = mean(Signals);
%               
%         % f2 = signal energy
%         features_energy = [];  
%                 
%         for j=1:size(Signals,2)  
%             T = size(Signals,1) ;
%             features_energy = [features_energy , T * sum(Signals(:,j) .* Signals(:,j))];
%         end
% 
%         % f3 = Standard deviation
%         features_std = [];
%         for j=1:size(Signals,2)  
%       
%             features_std = [features_std , std(Signals(:,j))];
%         end
% 
%         % f4 = peak-peak value
%         features_pkpk = [];
%         for j=1:size(Signals,2)  
%             h1 = dsp.PeakToPeak;
%             pkpk_val = step(h1, Signals(:,j));
%             features_pkpk = [features_pkpk , pkpk_val];
%         end
%         
%         % f7 = distance entre signaux. Feature sous forme X,Y,Z, X2,Y2,Z2
%         % d(X,Y) d(X,Z) d(Z,Y)
%         feature_dist  = [] ;
%         for j=1:3:size(Signals,2)
%             w = size(Signals(:,j),1);
%             distXY = dtw(Signals(:,j),Signals(:,j+1),w);
%             distXZ = dtw(Signals(:,j),Signals(:,j+2),w);
%             distZY = dtw(Signals(:,j+2),Signals(:,j+1),w);
%             feature_dist = [feature_dist , distXY , distXZ, distZY ];
%         end
%         
%         
%         % f8, f6 = peak and valley (number) position
%         features_pkpos = [];
%         features_valpos = [];
%         for j=1:size(Signals,2)  
%             [maxtab, mintab]=peakdet(Signals(:,j), 0.001);
%             features_pkpos = [ features_pkpos , size(maxtab,1) ];
%             features_valpos = [ features_valpos , size(mintab,1) ];
%         end

        
        % Feature combination
        testSet.occurence(i).features = [signal_features, mel_means, mel_std];%[features_mean, features_energy, features_std, features_pkpk, feature_dist, features_pkpos, features_valpos];
        testSet.occurence(i).label = currentLabel;
    end
    disp('--- Finished the loading of the Testset ---');
end