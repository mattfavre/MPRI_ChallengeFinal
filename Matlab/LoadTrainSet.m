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
    addpath('Feature Extraction'); 
    loadedSet = load(path);
    loadedSet = loadedSet.Dataset;
    
    lp_filter = load('filt.mat');
    
    signalbase = struct;
    
    for i=1:11
        trainingSet.occurenceCount(i) = 0;
    end
    
    
    for i=1:size(loadedSet.Data.occurence,1)
        currentLabel = loadedSet.Data.occurence(i).label+1; %the classes range is [0-10] but matlab only accepts [1-11] (so we need to handle that)
        currentOccurence = trainingSet.occurenceCount(currentLabel) + 1; %increase the current occurence of the gesture
        %In the following line we do the feature extraction and transpose the matrix as HMM require F x T and the current matrix is given as T x F (T is time and F is feature(s))
        Signals = loadedSet.Data.occurence(i).sensor(1).observation(:,featuresToExtract);
               
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
        
%        if  currentOccurence == 1
%             figure;
%             plot3(Signals(:,4),Signals(:,5),Signals(:,6));
%             title(['Magnitue XYZ du mouvement ' int2str(currentLabel-1)]);
%             xlabel('Capteur X');
%             ylabel('Capteur Y');
%             zlabel('Capteur Z');
%             grid on;
%             
%        end;
        
            
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
            
                    
       if  currentOccurence == 1
            figure;
            subplot(3,1,1);
            plot(Signals(:,n:n+2));
            title('Signaux XYZ');
            xlabel('Echantillons(t)');
            ylabel('Amplitude');
            subplot(3,1,2);
            plot(sigDeriv(:,1:3));
            title('Dérivée XYZ');
            xlabel('Echantillons(t)');
            ylabel('Amplitude');
            grid on;
            subplot(3,1,3);
            plot(addSigQuat(:,1));
            title('Signaux fusionné');
            xlabel('Echantillons(t)');
            ylabel('Amplitude');
            grid on;
            
            figure;
            subplot(2,1,1);
            plot(c);
            title('Melcepstr signal fusionné');
            xlabel('Cepstr frequency');
            ylabel('Amplitude');
            subplot(2,1,2);
            plot(extr);
            title('FFT');
            xlabel('Frequency');
            ylabel('Amplitude');
            grid on;
       end;

            
            signal_features = [extr', signal_features, sig_means, sig_std, sig_energy, sigD_energy, pkpk_val, sigd_mean, features_pkpos];
            mel_means = [mel_means , mean(c) , mean(cd), mel_energy] ;
            mel_std = [mel_std  , std(c), std(cd)];    
   
        end
        %%% TEST %%%%%        
       
        
        % Feature combination
        trainingSet.class(currentLabel).occurence(currentOccurence).features = [signal_features, mel_means, mel_std];
        trainingSet.occurenceCount(currentLabel) = currentOccurence; %update the number of occurence of the gesture with currentLabel
    end
     
    disp('--- Finished the loading of the Trainset ---');
end   