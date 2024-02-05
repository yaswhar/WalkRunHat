function analyzeAndWriteResults(folderPath, outputFile)
    % Get a list of all text files in the folder
     files = dir(fullfile(folderPath,'*.txt'));

    % Open the output file for writing results
    fid = fopen(outputFile, 'w');

    % Write header to the output file
    fprintf(fid, 'Dominant Frequency,Peak Average,Activity Label\n');
length(files)
    % Loop through each file in the folder
    for i = 1:length(files)
        % Read the data from the file
        data = load(fullfile(folderPath, files(i).name));
data=data(21:1:320,:);
        % Extract X-axis data
        X = data(:, 3);

        % Calculate dominant frequency
        Fs = calculateSamplingFrequency(data(:, 4));
        dominantFreqX = calculateDominantFrequency(X, Fs);

        % Calculate peak average
        peakAvgX = calculatePeakAverage(X);

        % Determine activity label based on file name prefix
        if startsWith(files(i).name, 'W')
            activityLabel = 1; % Walking
        elseif startsWith(files(i).name, 'R')
            activityLabel = 0; % Running
        else
            activityLabel = -1; % Undefined
        end

        % Write results to the output file
        fprintf(fid, '%f,%f,%d\n', dominantFreqX, peakAvgX, activityLabel);
    end

    % Close the output file
    fclose(fid);
end

function Fs = calculateSamplingFrequency(timestamps)
    time_diff = diff(timestamps);
    Fs = 1000 / mean(time_diff);
end

function dominantFreq = calculateDominantFrequency(signal, Fs)
    nfft = 1024;
    X_fft = fft(signal - mean(signal), nfft);
f_scale = (0:nfft/2)*Fs/nfft; % Fix the frequency scale
X_fft_abs= abs(X_fft.^2);
X_fft_abs = X_fft_abs(1:1+(nfft/2));
[~,X_freq_max_index]=max(X_fft_abs);
dominantFreq = f_scale(X_freq_max_index);
end


function peakAvg = calculatePeakAverage(signal)
    [peaksdata, ~] = findpeaks(abs(signal), 'MinPeakDistance', 100,'SortStr','descend');
    peakAvg = max(peaksdata(1:2));
end
