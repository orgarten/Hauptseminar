% ##############################################
% ########        audio correlator      ########
% ########        of stereo files       ########
% ########      developed for the       ########
% ########          Haupteseminar       ########
% ########      Kommunikationssysteme   ########
% ########          v 0.1               ########
% ##############################################
clear; clc;
%% input
% path of audiofile
% works with wav, mp3, flac, aif, au, aifc, ogg

pkg load signal;

path = '.\WAVE\music.wav';

% set priority (time/length)
priority = 'length';

% plot in samples or seconds
x_axis = 'samples';

% length of correlation
Lcor = 8192; 

% amount of correlations 
Ncor = 3;

% start of correlation in audio file in seconds 
t_start = 0;
t_end = 0.1;

%% CODE
%% load part of the signal from given path
%  row --> channel
[data, rate] = readAudio(path, t_start, t_end, Lcor, Ncor, priority); 

%% devide into Ncor parts
[channel_a, channel_b] = splitChannel(data, Lcor, Ncor, priority);

if strcmp(priority, 'time')
    Ncor = 1;
end

%% correlate 
for i = 1:1:Ncor
 % in time
    [correlation_t(i,:), lags(i,:)] = xcorr(channel_a(i,:), channel_b(i,:),'coeff');

 % in frequency 
    correlation_f(i,:) = freqMult(channel_a(i,:), channel_b(i,:));
end

%% calculate ripple factor and decline factor
ripple = calc_ripple(correlation_t, Ncor)

envelope = calc_envelope(correlation_t, length(channel_a), rate, Ncor);

% calculate offset between channels

[~,I] = max(abs(correlation_t(1,:)));
lagDiff = lags(I);
timeDiff = lagDiff/rate;



%% plot
for i = 1:Ncor
  plotTandF(channel_a(i,:), channel_b(i,:), correlation_t(i,:), correlation_f(i,:), envelope(i,:), x_axis, rate);
end

%% delete unneeded variables
%if strcmp(priority,'length') == 1
%    clearvars t_end i
%else
%    clearvars i Lcor Ncor
%end

%% save results

disp('finished');