clear; close all; clc

fprintf('Reading data ...\n');
data = load('E:\Term 7\Measurement\Project\codes\internet\RDATA4.TXT');
data=data(21:1:320,:);
time_diff = diff(data(:,4));
Fs = 1000 / mean(time_diff);
nfft =1024;
X=data(:,1);
starting=1;
ending=size(X,1);
X_fft = fft(X(starting:ending)-mean(X(starting:ending)),nfft); 
Y=data(:,2);
Y_fft = fft(Y(starting:ending)-mean(Y(starting:ending)),nfft); 
Z=data(:,3);
Z_fft = fft(Z(starting:ending)-mean(Z(starting:ending)),nfft); 
figure (1);
subplot(3,1,1);
plot(X);
ylabel('X-data');
subplot(3,1,2);
plot(Y);
ylabel('Y-data');
subplot(3,1,3);
plot(Z);
ylabel('Z-data');

f_scale = (0:nfft/2)*Fs/nfft;

figure(2);
X_fft_abs= abs(X_fft.^2);
X_fft_abs = X_fft_abs(1:1+(nfft/2));
[X_max,X_freq_max_index]=max(X_fft_abs);
X_max_freq = f_scale(X_freq_max_index);
plot(f_scale,X_fft_abs);
ylabel('X-fft-data');

figure(3);
Y_fft_abs= abs(Y_fft.^2);
Y_fft_abs = Y_fft_abs(1:1+(nfft/2));
[Y_max,Y_freq_max_index]=max(Y_fft_abs);
Y_max_freq = f_scale(Y_freq_max_index);
plot(f_scale,Y_fft_abs);
ylabel('Y-fft-data');

figure(4);
Z_fft_abs= abs(Z_fft.^2);
Z_fft_abs = Z_fft_abs(1:1+(nfft/2));
[Z_max,Z_freq_max_index]=max(Z_fft_abs);
Z_max_freq = f_scale(Z_freq_max_index);
plot(f_scale,Z_fft_abs);
ylabel('Z-fft-data');

fprintf('X Dominant Freq.: %f Hz \n',X_max_freq);

[peaksdata, ~] = findpeaks(abs(X), 'MinPeakDistance', 100);
fprintf('X peak average is.: %f \n',mean(peaksdata));

fprintf('Y Dominant_freq.: %f Hz \n',Y_max_freq);

[peaksdata, ~] = findpeaks(abs(Y), 'MinPeakDistance', 100);
fprintf('Y peak average is.: %f \n',mean(peaksdata));

fprintf('Z Dominant_freq.: %f Hz \n',Z_max_freq);

[peaksdata, ~] = findpeaks(abs(Z), 'MinPeakDistance', 100);
fprintf('Z peak average is.: %f \n',mean(peaksdata));