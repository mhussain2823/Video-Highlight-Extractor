# Video Highlight Extractor 🎬

This MATLAB script automatically generates highlights from a video by analyzing the audio amplitude.  
It extracts the loudest parts of the video (where the most action happens) and saves them as short clips.

## Features
- Extracts audio using FFmpeg
- Finds the most energetic segment in the audio
- Creates random highlight clips (15–50 seconds)
- Saves highlight video in the output folder

## Requirements
- MATLAB (R2020b or later recommended)
- FFmpeg installed and added to system PATH

## Usage
1. Set your video path in the script:
   ```matlab
   videoFile = "C:\path\to\your\video.mp4";
