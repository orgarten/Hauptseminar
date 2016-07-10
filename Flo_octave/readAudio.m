function [ data, rate ] = readAudio( filename, t_start, t_end, Lcor, Ncor, priority )
% READAUDIO reads the audio file and saves it in data
%   which part of the file is read is decided by priority and additional
%   values
% read entire file and samplerate
[data, rate] = audioread(filename);

% choose area
% second element of the range vector is the start in samples
% plus N-times (how many blocks you want to correlate) the correlation window
% in samples
if strcmp(priority,'time') == 1
    range = [1+t_start*rate t_start*rate+(t_end-t_start)*rate*Ncor];
else
    range = [1+t_start*rate t_start*rate+Lcor*Ncor];
end
range =round(range);

% load correct area
[data, rate] = audioread(filename, range);

% transform matrix
% because Flo likes it more when you see the audio from left to right
% and not from top to bottom :-D
data = data';
end

