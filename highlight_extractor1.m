clc; clear; close all;

% Input Files
videoFile = "C:\Users\hussa\Downloads\Project\Video_1.mp4";
audioFile = "C:\Users\hussa\Downloads\Project\audio.wav";
highlightDir = "C:\Users\hussa\Downloads\Project\Highlights";


% Create output folder
if ~exist(highlightDir, 'dir')
    mkdir(highlightDir);
end

% STEP 1: Extract Audio via ffmpeg
cmdExtract = sprintf('ffmpeg -y -i "%s" -vn -ac 1 -ar 16000 "%s"', videoFile, audioFile);
system(cmdExtract);

% STEP 2: Load Audio
[audio, fs] = audioread(audioFile);

% STEP 3: Compute Energy
window = round(fs * 1);    
overlap = round(window * 0.5);
energy = buffer(audio(:,1).^2, window, overlap, 'nodelay');
energyVal = sum(energy, 1);
t = (1:length(energyVal)) * (window-overlap) / fs;

% STEP 4: Find Highlight
[~, idx] = max(energyVal);
offset = randi([8 14]);              % random offset between 8–14 sec
startTime = max(0, t(idx) - offset);  
duration = randi([15 50]);   % random duration between 15–50 sec;                  

% STEP 5: Trim Video
outFile = fullfile(highlightDir, "4highlight_1.mp4");
cmdTrim = sprintf('ffmpeg -y -ss %.2f -i "%s" -t %.2f -c copy "%s"', ...
              startTime, videoFile, duration, outFile);
system(cmdTrim);

fprintf("✅ Highlight saved: %s\n", outFile);
