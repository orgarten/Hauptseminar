% ##############################################
% ########        audio correlator      ########
% ########        of stereo files       ########
% ########      developed for the       ########
% ########          Haupteseminar       ########
% ########      Kommunikationssysteme   ########
% ########          v 0.1               ########
% ##############################################
clear; clc;
pkg load signal;
pkg load optim;
pkg load io;


% path to folder with audiofiles
% works with wav, mp3, flac, aif, au, aifc, ogg
path = 'WAVE\';
excel_path = 'data.xlsx';
% results (display/save)
output = 'display';

% calculate correlation with (xcorr/freqMult)
calc = 'freqMult';

% set priority (time/length)
priority = 'length';

% plot in (samples/seconds)
x_axes = 'seconds';

% length of correlation
Lcor = 8192; 

% amount of correlations 
Ncor = 2;

% start of correlation in audio file in seconds 
t_start = 1;
t_end = 1.1;

%----------------------------------------
%Read Files
wav_files = search_dir(path);
%correlate files
A = {};
for i = 1:length(wav_files(1,:))
  [corr, param] = audiocorrelation(wav_files{1,i}, output, calc, priority, x_axes, Lcor, Ncor, t_start, t_end);
  A = buildXLSMatrix(A, wav_files{1,i}, param(1), param(2), param(3), param(4));
end
%save to excel file
writeEXCEL(excel_path, A);
%----------------------------------------


disp('finished');
