%Check for .dat files
if isempty(dataFiles)
    error('No .dat files found in the selected folder.');
end

%Loop through .dat files
for i = 1:20
    fileName = dataFiles(i).name;
    baseName = fileName(1:end-4); %Remove .dat extension
    
    %Read signals with rdsamp
    try
        [signals, ~] = rdsamp(baseName); 
        [x, y] = size(signals)
    catch ME
        warning('Could not read file: %s. Skipping...', fileName);
        continue;
    end

    %Extract signals
    ecg1 = signals(:, 1); %ECG1
    ecg2 = signals(:, 2); %ECG2

    %Plot ECG1
    figure;
    plot(ecg1);
    title(['ECG1 Signal from ', fileName]);
    xlabel('Time (ms)');
    ylabel('Amplitude');
    xlim([0 min(10000, length(ecg1))]);
    grid on;

    %Plot ECG2
    figure;
    plot(ecg2);
    title(['ECG2 Signal from ', fileName]);
    xlabel('Time (ms)');
    ylabel('Amplitude');
    xlim([0 min(10000, length(ecg2))]);
    grid on;
    if y > 2
    nibp = signals(:, 3); %NIBP
    %Plot NIBP
    figure;
    plot(nibp);
    title(['NIBP Signal from ', fileName]);
    xlabel('Time (ms)');
    ylabel('Amplitude');
    xlim([0 min(10000, length(nibp))]);
    grid on;
    end
end


plot(nibp);
title('NIBP Signal');
xlabel('Time (ms)');
ylabel('Amplitude');
xlim([0 10000]);
grid on;
