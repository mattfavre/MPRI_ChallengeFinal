% HMM exercise  
% -------------

disp ('-------- reading signal and computing cepstra ----------');

%-----------reading in the training data----------------------------------

[training_data1_1,Fs1_1,bits1]=wavread('Matthieu/1_1.wav');
[training_data1_2,Fs1_2,bits1]=wavread('Matthieu/1_2.wav');
[training_data1_3,Fs1_3,bits1]=wavread('Matthieu/1_3.wav');
[training_data2_1,Fs2_1,bits2]=wavread('Matthieu/2_1.wav');
[training_data2_2,Fs2_2,bits2]=wavread('Matthieu/2_2.wav');
[training_data2_3,Fs2_3,bits2]=wavread('Matthieu/2_3.wav');
[training_data3_1,Fs3_1,bits3]=wavread('Matthieu/3_1.wav');
[training_data3_2,Fs3_2,bits3]=wavread('Matthieu/3_2.wav');
[training_data3_3,Fs3_3,bits3]=wavread('Matthieu/3_3.wav');
[training_data4_1,Fs4_1,bits4]=wavread('Matthieu/4_1.wav');
[training_data4_2,Fs4_2,bits4]=wavread('Matthieu/4_2.wav');
[training_data4_3,Fs4_3,bits4]=wavread('Matthieu/4_3.wav');
[training_data5_1,Fs5_1,bits5]=wavread('Matthieu/5_1.wav');
[training_data5_2,Fs5_2,bits5]=wavread('Matthieu/5_2.wav');
[training_data5_3,Fs5_3,bits5]=wavread('Matthieu/5_3.wav');


[testing_data1,Fs1t,bits1t]=wavread('Michael/1t.wav');
[testing_data2,Fs2t,bits2t]=wavread('Michael/2t.wav');
[testing_data3,Fs3t,bits3t]=wavread('Michael/3t.wav');
[testing_data4,Fs4t,bits4t]=wavread('Michael/4t.wav');
[testing_data5,Fs5t,bits5t]=wavread('Michael/5t.wav');

[testing_datap,Fspt,bitspt]=wavread('Matthieu/Peut.wav');


%-------------feature extraction, 12 coeff. ------------------------------------------
c1_1=melcepst(training_data1_1,Fs1_1)';
c1_2=melcepst(training_data1_2,Fs1_2)';
c1_3=melcepst(training_data1_3,Fs1_3)';

c2_1=melcepst(training_data2_1,Fs2_1)';
c2_2=melcepst(training_data2_2,Fs2_2)';
c2_3=melcepst(training_data2_3,Fs2_3)';

c3_1=melcepst(training_data3_1,Fs3_1)';
c3_2=melcepst(training_data3_2,Fs3_2)';
c3_3=melcepst(training_data3_3,Fs3_3)';

c4_1=melcepst(training_data4_1,Fs4_1)';
c4_2=melcepst(training_data4_2,Fs4_2)';
c4_3=melcepst(training_data4_3,Fs4_3)';

c5_1=melcepst(training_data5_1,Fs5_1)';
c5_2=melcepst(training_data5_2,Fs5_2)';
c5_3=melcepst(training_data5_3,Fs5_3)';

c1t=melcepst(testing_data1,Fs1t)';
c2t=melcepst(testing_data2,Fs2t)';
c3t=melcepst(testing_data3,Fs3t)';
c4t=melcepst(testing_data4,Fs4t)';
c5t=melcepst(testing_data5,Fs5t)';

cp=melcepst(testing_datap,Fspt)';

%-------------------------------------------------------------------------
%TODO: afficher la dur�e des fichiers d'entra�nement (en millisecondes) ainsi 
%que le nombre de vecteurs acoustiques qui en sont extraits (nombre de colonnes de la matrice ci_i)

% Periode d'un �chantillons des fichiers
T1_1 = 1/Fs1_1;
T1_2 = 1/Fs1_2;
T1_3 = 1/Fs1_3;
T2_1 = 1/Fs2_1;
T2_2 = 1/Fs2_2;
T2_3 = 1/Fs2_3;
T3_1 = 1/Fs3_1;
T3_2 = 1/Fs3_2;
T3_3 = 1/Fs3_3;
T4_1 = 1/Fs4_1;
T4_2 = 1/Fs4_2;
T4_3 = 1/Fs4_3;
T5_1 = 1/Fs5_1;
T5_2 = 1/Fs5_2;
T5_3 = 1/Fs5_3;

% Calcul du temps moyen en miliseconde
t_wav_1_1 = length(training_data1_1) * T1_1 * 1000 ; % (Nb echantillons * periode * 1000) ms
t_wav_1_2 = length(training_data1_2) * T1_2 * 1000 ; % (Nb echantillons * periode * 1000) ms
t_wav_1_3 = length(training_data1_3) * T1_3 * 1000 ; % (Nb echantillons * periode * 1000) ms
t_wav_2_1 = length(training_data2_1) * T2_1 * 1000 ; % (Nb echantillons * periode * 1000) ms
t_wav_2_2 = length(training_data2_2) * T2_2 * 1000 ; % (Nb echantillons * periode * 1000) ms
t_wav_2_3 = length(training_data2_3) * T2_3 * 1000 ; % (Nb echantillons * periode * 1000) ms
t_wav_3_1 = length(training_data3_1) * T3_1 * 1000 ; % (Nb echantillons * periode * 1000) ms
t_wav_3_2 = length(training_data3_2) * T3_2 * 1000 ; % (Nb echantillons * periode * 1000) ms
t_wav_3_3 = length(training_data3_3) * T3_3 * 1000 ; % (Nb echantillons * periode * 1000) ms
t_wav_4_1 = length(training_data4_1) * T4_1 * 1000 ; % (Nb echantillons * periode * 1000) ms
t_wav_4_2 = length(training_data4_2) * T4_2 * 1000 ; % (Nb echantillons * periode * 1000) ms
t_wav_4_3 = length(training_data4_3) * T4_3 * 1000 ; % (Nb echantillons * periode * 1000) ms
t_wav_5_1 = length(training_data5_1) * T5_1 * 1000 ; % (Nb echantillons * periode * 1000) ms
t_wav_5_2 = length(training_data5_2) * T5_2 * 1000 ; % (Nb echantillons * periode * 1000) ms
t_wav_5_3 = length(training_data5_3) * T5_3 * 1000 ; % (Nb echantillons * periode * 1000) ms

t_wav1 = (t_wav_1_1 + t_wav_1_2 + t_wav_1_3) / 3 ;
t_wav2 = (t_wav_2_1 + t_wav_2_2 + t_wav_2_3) / 3 ;
t_wav3 = (t_wav_3_1 + t_wav_3_2 + t_wav_3_3) / 3 ;
t_wav4 = (t_wav_4_1 + t_wav_4_2 + t_wav_4_3) / 3 ;
t_wav5 = (t_wav_5_1 + t_wav_5_2 + t_wav_5_3) / 3 ;

disp(['Temps moyen pour chiffre 1 = ' num2str(t_wav1) ' ms']);
disp(['Temps moyen pour chiffre 2 = ' num2str(t_wav2) ' ms']);
disp(['Temps moyen pour chiffre 3 = ' num2str(t_wav3) ' ms']);
disp(['Temps moyen pour chiffre 4 = ' num2str(t_wav4) ' ms']);
disp(['Temps moyen pour chiffre 5 = ' num2str(t_wav5) ' ms']);

% Calcul du nombre de vecteur acoustique moyen
c1 = (size(c1_1,2) + size(c1_2,2) + size(c1_3,2)) / 3 ;
c2 = (size(c2_1,2) + size(c2_2,2) + size(c2_3,2)) / 3 ;
c3 = (size(c3_1,2) + size(c3_2,2) + size(c3_3,2)) / 3 ;
c4 = (size(c4_1,2) + size(c4_2,2) + size(c4_3,2)) / 3 ;
c5 = (size(c5_1,2) + size(c5_2,2) + size(c5_3,2)) / 3 ;

disp(['Nombre de vecteurs acoustiques pour chiffre 1 = ' num2str(c1)]);
disp(['Nombre de vecteurs acoustiques pour chiffre 2 = ' num2str(c2)]);
disp(['Nombre de vecteurs acoustiques pour chiffre 3 = ' num2str(c3)]);
disp(['Nombre de vecteurs acoustiques pour chiffre 4 = ' num2str(c4)]);
disp(['Nombre de vecteurs acoustiques pour chiffre 5 = ' num2str(c5)]);


%-------------------------------------------------------------------------


disp ('-------- training model for 1 ----------');
%-------------------------------------------------------------------------
%TODO : utiser la bonne valeur de N pour le training de vos mod�les!!
%N=5
N=5; 
A=inittran(N); [MI,SIGMA]=initemis(c1_1,N); 
[NEWA, NEWMI, NEWSIGMA, Ptot] = vit_reestim (c1_1,c1_2,c1_3, A, MI, SIGMA);
disp(['Ptot pour chiffre 1 = 1t' num2str(Ptot)]);
for iter=1:5
   [NEWA,NEWMI,NEWSIGMA,Ptot] = vit_reestim (c1_1,c1_2,c1_3, NEWA, NEWMI, SIGMA);  
   disp(['Ptot pour chiffre 1 = 1t' num2str(Ptot)]);
   %Ptot
end
A1=NEWA; MI1=NEWMI; SIGMA1=SIGMA;

disp ('-------- training model for 2 ----------');
N=6; 
A=inittran(N); [MI,SIGMA]=initemis(c2_1,N); 
[NEWA, NEWMI, NEWSIGMA, Ptot] = vit_reestim (c2_1,c2_2,c2_3, A, MI, SIGMA);
disp(['Ptot pour chiffre 2 = 1t' num2str(Ptot)]);
for iter=1:5  
   [NEWA,NEWMI,NEWSIGMA,Ptot] = vit_reestim (c2_1,c2_2,c2_3, NEWA, NEWMI, SIGMA);
   disp(['Ptot pour chiffre 2 = 1t' num2str(Ptot)]);
   %Ptot
end
A2=NEWA; MI2=NEWMI; SIGMA2=SIGMA;

disp ('-------- training model for 3 ----------');
N=8; 
A=inittran(N); [MI,SIGMA]=initemis(c3_1,N); 
[NEWA, NEWMI, NEWSIGMA, Ptot] = vit_reestim (c3_1,c3_2,c3_3, A, MI, SIGMA);
disp(['Ptot pour chiffre 3 = 1t' num2str(Ptot)]);
for iter=1:5  
   [NEWA,NEWMI,NEWSIGMA,Ptot] = vit_reestim (c3_1,c3_2,c3_3, NEWA, NEWMI, SIGMA);  
   disp(['Ptot pour chiffre 3 = 1t' num2str(Ptot)]);
   %Ptot
end
A3=NEWA; MI3=NEWMI; SIGMA3=SIGMA;

disp ('-------- training model for 4 ----------');
N=8; 
A=inittran(N); [MI,SIGMA]=initemis(c4_1,N); 
[NEWA, NEWMI, NEWSIGMA, Ptot] = vit_reestim (c4_1,c4_2,c4_3, A, MI, SIGMA);
disp(['Ptot pour chiffre 4 = 1t' num2str(Ptot)]);
for iter=1:5
   [NEWA,NEWMI,NEWSIGMA,Ptot] = vit_reestim (c4_1,c4_2,c4_3, NEWA, NEWMI, SIGMA);  
   disp(['Ptot pour chiffre 4 = 1t' num2str(Ptot)]);
   %Ptot
end
A4=NEWA; MI4=NEWMI; SIGMA4=SIGMA;

disp ('-------- training model for 5 ----------');
N=7; 
A=inittran(N); [MI,SIGMA]=initemis(c5_1,N); 
[NEWA, NEWMI, NEWSIGMA, Ptot] = vit_reestim (c5_1,c5_2,c5_3, A, MI, SIGMA);
disp(['Ptot pour chiffre 5 = 1t' num2str(Ptot)]);
for iter=1:5
   [NEWA,NEWMI,NEWSIGMA,Ptot] = vit_reestim (c5_1,c5_2,c5_3, NEWA, NEWMI, SIGMA);  
   disp(['Ptot pour chiffre 5 = 1t' num2str(Ptot)]);
   %Ptot
end
A5=NEWA; MI5=NEWMI; SIGMA5=SIGMA;


disp ('====== now recognizing  =======') 
%format short e % this is to see correctly all elements of a vector

Pvit11 = viterbi_log (c1t, A1, MI1, SIGMA1);
Pvit12 = viterbi_log (c1t, A2, MI2, SIGMA2);
Pvit13 = viterbi_log (c1t, A3, MI3, SIGMA3);
Pvit14 = viterbi_log (c1t, A4, MI4, SIGMA4);
Pvit15 = viterbi_log (c1t, A5, MI5, SIGMA5);
h1=[Pvit11 Pvit12 Pvit13 Pvit14 Pvit15]
[nic,ii]=max(h1); disp(['testing for 1t, the best model is ' num2str(ii) ]);

Pvit11 = viterbi_log (c2t, A1, MI1, SIGMA1);
Pvit12 = viterbi_log (c2t, A2, MI2, SIGMA2);
Pvit13 = viterbi_log (c2t, A3, MI3, SIGMA3);
Pvit14 = viterbi_log (c2t, A4, MI4, SIGMA4);
Pvit15 = viterbi_log (c2t, A5, MI5, SIGMA5);
h2=[Pvit11 Pvit12 Pvit13 Pvit14 Pvit15]
[nic,ii]=max(h2); disp(['testing for 2t, the best model is ' num2str(ii) ]);

Pvit11 = viterbi_log (c3t, A1, MI1, SIGMA1);
Pvit12 = viterbi_log (c3t, A2, MI2, SIGMA2);
Pvit13 = viterbi_log (c3t, A3, MI3, SIGMA3);
Pvit14 = viterbi_log (c3t, A4, MI4, SIGMA4);
Pvit15 = viterbi_log (c3t, A5, MI5, SIGMA5);
h3=[Pvit11 Pvit12 Pvit13 Pvit14 Pvit15]
[nic,ii]=max(h3); disp(['testing for 3t, the best model is ' num2str(ii) ]);

Pvit11 = viterbi_log (c4t, A1, MI1, SIGMA1);
Pvit12 = viterbi_log (c4t, A2, MI2, SIGMA2);
Pvit13 = viterbi_log (c4t, A3, MI3, SIGMA3);
Pvit14 = viterbi_log (c4t, A4, MI4, SIGMA4);
Pvit15 = viterbi_log (c4t, A5, MI5, SIGMA5);
h4=[Pvit11 Pvit12 Pvit13 Pvit14 Pvit15]
[nic,ii]=max(h4); disp(['testing for 4t, the best model is ' num2str(ii) ]);

Pvit11 = viterbi_log (c5t, A1, MI1, SIGMA1);
Pvit12 = viterbi_log (c5t, A2, MI2, SIGMA2);
Pvit13 = viterbi_log (c5t, A3, MI3, SIGMA3);
Pvit14 = viterbi_log (c5t, A4, MI4, SIGMA4);
Pvit15 = viterbi_log (c5t, A5, MI5, SIGMA5);
h5=[Pvit11 Pvit12 Pvit13 Pvit14 Pvit15]
[nic,ii]=max(h5); disp(['testing for 5t, the best model is ' num2str(ii) ]);


Pvit11 = viterbi_log (cp, A1, MI1, SIGMA1);
Pvit12 = viterbi_log (cp, A2, MI2, SIGMA2);
Pvit13 = viterbi_log (cp, A3, MI3, SIGMA3);
Pvit14 = viterbi_log (cp, A4, MI4, SIGMA4);
Pvit15 = viterbi_log (cp, A5, MI5, SIGMA5);
hp=[Pvit11 Pvit12 Pvit13 Pvit14 Pvit15]
[nic,ii]=max(hp); disp(['testing for peu, the best model is ' num2str(ii) ]);


xp = [1:1:5];


figure(1);
subplot(6,1,1)
plot(xp,h1);
title 'Probabilités de reconnaissances';
xlabel 'Chiffre';
ylabel 'Probabilité';
legend('Chiffre 1');

subplot(6,1,2)
plot(xp,h2);
title 'Probabilités de reconnaissances';
xlabel 'Chiffre';
ylabel 'Probabilité';
legend('Chiffre 2');

subplot(6,1,3)
plot(xp,h3);
title 'Probabilités de reconnaissances';
xlabel 'Chiffre';
ylabel 'Probabilité';
legend('Chiffre 3');

subplot(6,1,4)
plot(xp,h4);
title 'Probabilités de reconnaissances';
xlabel 'Chiffre';
ylabel 'Probabilité';
legend('Chiffre 4');

subplot(6,1,5)
plot(xp,h5);
title 'Probabilités de reconnaissances';
xlabel 'Chiffre';
ylabel 'Probabilité';
legend('Chiffre 5');

subplot(6,1,6)
plot(xp,hp);
title 'Probabilités de reconnaissances';
xlabel 'Chiffre';
ylabel 'Probabilité';
legend('Peu');

figure(2);
pl = plot(xp,h1,xp,h2,xp,h3,xp,h4,xp,h5,xp,hp);
set(pl(1),'LineWidth',2);
set(pl(2),'LineWidth',2);
set(pl(3),'LineWidth',2);
set(pl(4),'LineWidth',2);
set(pl(5),'LineWidth',2);
set(pl(6),'LineWidth',2);

title 'Probabilités de reconnaissances';
xlabel 'Chiffre';
ylabel 'Probabilité';
legend('Chiffre 1','Chiffre 2','Chiffre 3','Chiffre 4','Chiffre 5','Peu')

