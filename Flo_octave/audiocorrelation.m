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
priority = 'time';

% length of correlation
Lcor = 8192; 

% amount of correlations 
Ncor = 1;

% start of correlation in audio file in seconds 
t_start = 0;
t_end = 0.1;

%plot in samples or seconds
x_axis = 'seconds';


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

%% plot

%% calculate ripple factor and decline factor
ripple = calc_ripple(correlation_t)

[~,I] = max(abs(correlation_t));
lagDiff = lags(I)
timeDiff = lagDiff/rate

envelope = calc_envelope(correlation_t, length(channel_a), rate);
%envelope = correlation_t;

plotTandF(channel_a, channel_b, correlation_t(1,:), correlation_f(1,:), envelope, x_axis, rate);




%% delete unneeded variables
%if strcmp(priority,'length') == 1
%    clearvars t_end i
%else
%    clearvars i Lcor Ncor
%end

%% save results

disp('finished');