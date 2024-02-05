data = load('E:\Term 7\Measurement\Project\codes\testR.TXT');
load('theta.mat');
data=data(21:1:320,:);
X = data(:, 3);
time_diff = diff(data(:,4));
Fs = 1000 / mean(time_diff);
nfft = 1024;
X_fft = fft(X - mean(X), nfft);
f_scale = (0:nfft/2)*Fs/nfft; % Fix the frequency scale
X_fft_abs= abs(X_fft.^2);
X_fft_abs = X_fft_abs(1:1+(nfft/2));
[~,X_freq_max_index]=max(X_fft_abs);
dominantFreq = f_scale(X_freq_max_index);
[peaksdata, ~] = findpeaks(abs(X), 'MinPeakDistance', 100);
peakAvg = max(peaksdata);
if round(sigmoid([1 dominantFreq peakAvg]*theta),2,"decimals")==1.0
    disp('Walking')
else
    disp('Running')
end
