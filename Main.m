%BME772 Lab 4
%% Loading Data and Definitions
load('/Volumes/GoogleDrive/My Drive/University/BME772 Signal Analysis/Lab 4/lab4data.mat');
[FA,fs2]= audioread('/Volumes/GoogleDrive/My Drive/University/BME772 Signal Analysis/Lab 4/Data/female_a.wav');
[FI,fs2]= audioread('/Volumes/GoogleDrive/My Drive/University/BME772 Signal Analysis/Lab 4/Data/female_i.wav');
[FU,fs2]= audioread('/Volumes/GoogleDrive/My Drive/University/BME772 Signal Analysis/Lab 4/Data/female_u.wav');
[MA,fs2]= audioread('/Volumes/GoogleDrive/My Drive/University/BME772 Signal Analysis/Lab 4/Data/male_a.wav');
[MI,fs2]= audioread('/Volumes/GoogleDrive/My Drive/University/BME772 Signal Analysis/Lab 4/Data/male_i.wav');
[MU,fs2]= audioread('/Volumes/GoogleDrive/My Drive/University/BME772 Signal Analysis/Lab 4/Data/male_u.wav');
MV = MALE_S;
FV = FEMALES;
fs=12500;
%%                                             Get All The Signals 

%% Set up the variables

%Length of Signals
MV_l=length(MV);
FV_l=length(FV);
FA_l=length(FA);
FI_l=length(FI);
FU_l=length(FU);
MA_l=length(MA);
MI_l=length(MI);
MU_l=length(MU);
%Time Vector of Each Signal
MV_t=(0:MV_l-1)/fs;
FV_t=(0:FV_l-1)/fs;
FA_t=(0:FA_l-1)/fs2;
FI_t=(0:FI_l-1)/fs2;
FU_t=(0:FU_l-1)/fs2;
MA_t=(0:MA_l-1)/fs2;
MI_t=(0:MI_l-1)/fs2;
MU_t=(0:MU_l-1)/fs2;

%% Auto Correlation

% Running Autocorrelation 
MV_AC=myACF(MV);
FV_AC=myACF(FV);
FA_AC=myACF(FA);
FI_AC=myACF(FI);
FU_AC=myACF(FU);
MA_AC=myACF(MA);
MI_AC=myACF(MI);
MU_AC=myACF(MU);

% Selecting a segment of the signal
MV_seg=MV_AC(1:500);
FV_seg=FV_AC(1:500);
FA_seg=FA_AC(1:500);
FI_seg=FI_AC(1:500);
FU_seg=FU_AC(1:500);
MA_seg=MA_AC(1:500);
MI_seg=MI_AC(1:500);
MU_seg=MU_AC(1:500);

%% Pitch Period

%Female Pitch Period
[pksFV,locsFV] = findpeaks(FV_seg, 'MinPeakHeight', 0.25, 'MinPeakDistance', 15);
FV_pp = locsFV(2) - locsFV(1);
%Male Pitch Period
[pksMV,locsMV] = findpeaks(MV_seg, 'MinPeakHeight', 0.25);
MV_pp = locsMV(2) - locsMV(1);

%Audiofile Female Pitch Period
[pksFA,locsFA] = findpeaks(FA_seg, 'MinPeakHeight', 0.6);
FA_pp = locsFA(2) - locsFA(1);
[pksFI,locsFI] = findpeaks(FI_seg, 'MinPeakHeight', 0.6);
FI_pp = locsFI(2) - locsFI(1);
[pksFU,locsFU] = findpeaks(FU_seg, 'MinPeakHeight', 0.6);
FU_pp = locsFU(2) - locsFU(1);

%Audiofile Male Pitch Period
[pksMA,locsMA] = findpeaks(MA_seg);
MA_pp = locsMA(2) - locsMA(1);
[pksMI,locsMI] = findpeaks(MI_seg);
MI_pp = locsMI(2) - locsMI(1);
[pksMU,locsMU] = findpeaks(MU_seg);
MU_pp = locsMU(2) - locsMU(1);

FV_pp_disp =['In FV, the Pitch Period is ',num2str(FV_pp)];
disp(FV_pp_disp);
MV_pp_disp =['In MV, the Pitch Period is ',num2str(MV_pp)];
disp(MV_pp_disp);
FA_pp_disp =['In FA, the Pitch Period is ',num2str(FA_pp)];
disp(FA_pp_disp);
FI_pp_disp =['In FI, the Pitch Period is ',num2str(FI_pp)];
disp(FI_pp_disp);
FU_pp_disp =['In FU, the Pitch Period is ',num2str(FU_pp)];
disp(FU_pp_disp);
MA_pp_disp =['In MA, the Pitch Period is ',num2str(MA_pp)];
disp(MA_pp_disp);
MI_pp_disp =['In MI, the Pitch Period is ',num2str(MI_pp)];
disp(MI_pp_disp);
MU_pp_disp =['In MU, the Pitch Period is ',num2str(MU_pp)];
disp(MU_pp_disp);

%% Frequency Spectrum

ssMV = (abs(fft(MV)));%finding the amplitude in f spectrum
ssFV = (abs(fft(FV)));
ssFA = (abs(fft(FA)));
ssFI = (abs(fft(FI)));
ssFU = (abs(fft(FU)));
ssMA = (abs(fft(MA)));
ssMI = (abs(fft(MI)));
ssMU = (abs(fft(MU)));

MV_f = [1:MV_l]*(fs/MV_l);%changing the x-axis to Hertz
FV_f = [1:FV_l]*(fs/FV_l);
FA_f = [1:FA_l]*(fs2/FA_l);
FI_f = [1:FI_l]*(fs2/FI_l);
FU_f = [1:FU_l]*(fs2/FU_l);
MA_f = [1:MA_l]*(fs2/MA_l);
MI_f = [1:MI_l]*(fs2/MI_l);
MU_f = [1:MU_l]*(fs2/MU_l);

%% Formants

% Enveloping using peaks, seperated over at least N points
[upFV,lowFV] = envelope(ssFV,110,'peak');
[upMV,lowMV] = envelope(ssMV,80,'peak');
[upFA,lowFA] = envelope(ssFA,400,'peak');
[upFI,lowFI] = envelope(ssFI,176,'peak');
[upFU,lowFU] = envelope(ssFU,260,'peak');
[upMA,lowMA] = envelope(ssMA,400,'peak');
[upMI,lowMI] = envelope(ssMI,600,'peak');
[upMU,lowMU] = envelope(ssMU,560,'peak');

% Finding the peak of the envelope
[EpksFV,ElocsFV] = findpeaks(upFV, 'MinPeakProminence', 5);
[EpksMV,ElocsMV] = findpeaks(upMV);

[EpksFA,ElocsFA] = findpeaks(upFA, 'MinPeakProminence', 25);
[EpksFI,ElocsFI] = findpeaks(upFI, 'MinPeakHeight', 25, 'MinPeakProminence', 70);
[EpksFU,ElocsFU] = findpeaks(upFU, 'MinPeakProminence', 3);

[EpksMA,ElocsMA] = findpeaks(upMA);
[EpksMI,ElocsMI] = findpeaks(upMI, 'MinPeakWidth', 700, 'MinPeakProminence', 50);
[EpksMU,ElocsMU] = findpeaks(upMU, 'MinPeakProminence', 15);

% Matching envelope peak location and frequency spectrum
ElocsFV = ElocsFV*(fs/FV_l);
ElocsMV = ElocsMV*(fs/MV_l);
ElocsFA = ElocsFA*(fs2/FA_l);
ElocsFI = ElocsFI*(fs2/FI_l);
ElocsFU = ElocsFU*(fs2/FU_l);
ElocsMA = ElocsMA*(fs2/MA_l);
ElocsMI = ElocsMI*(fs2/MI_l);
ElocsMU = ElocsMU*(fs2/MU_l);

%% Finding Formant Values

fmtsF = ElocsFV(1:2);
fmtsM = ElocsMV(1:2);
fmtsFA = ElocsFA(1:2);
fmtsFI = ElocsFI(1:2);
fmtsFU = ElocsFU(1:2);
fmtsMA = ElocsMA(1:2);
fmtsMI = ElocsMI(1:2);
fmtsMU = ElocsMU(1:2);

%% Plotting

data = FU; 
data_time = FU_t; 
data_seg = FU_seg; 
data_locs = locsFU; 
data_pks = pksFU; 
data_f = FU_f; 
data_ss = ssFU; 
data_up = upFU; 
data_Elocs = ElocsFU; 
data_Epks = EpksFU;

BME772Lab4Plotting(data,data_time,data_seg,data_locs,data_pks,data_f,data_ss,data_up,data_Elocs,data_Epks);

%% Finding the Ratio

ratio_signal = FU;
ratio_signal_ACF = FU_AC;
BME772Lab4Ratio(ratio_signal,ratio_signal_ACF)
%% Plotting Ratio Values

% My ratio values
formant_ratio_F=[0.199158, 0.08,0.09804,0.17681];
formant_ratio_M=[0.20818,0.06507,0.075,0.26895];

% Shana's ratio values
%formant_ratio_F=[0.199, 0.08, 0.098, 0.176];
%formant_ratio_M=[0.209, 0.065, 0.075, 0.269];

x = (0:1);% Preparing a linear line
figure;
hold on
scatter(formant_ratio_M,formant_ratio_F);% Plot Male and Female ratios agaisnt one another
plot(x,x);% Plot a linear line
hold off
title('Formant Ratio: Male vs. Female');
xlabel('Male Formant Ratio');
xlim([0 0.4]);
ylabel('Female Formant Ratio');
ylim([0 0.4]);
legend('Formant Ratio');




