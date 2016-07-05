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
excel_path = 'RESULTS\data.xlsx';
% results (display/save_param/save_all)
output = 'display';

% calculate correlation with (xcorr/freqMult)
calc = 'freqMult';

% plot in (samples/seconds)
x_axes = 'seconds';

% set priority (time/length)
priority = 'time';

% length -> length of correlation
Lcor = 8192; 

% length -> amount of correlations 
Ncor = 2;

% start of correlation in audio file in seconds
% time -> and durations 
t_start = 4;
t_dur = [1];

tic
%----------------------------------------
if strcmp(priority, 'time')
   Ncor = 1;
end

%Read Files
wav_files = search_dir(path);
%correlate files
A = {};
for i = 1:length(wav_files(1,:))
  for k = 1:length(t_dur)
    t_end = t_start + t_dur(k);
    [corr, param] = audiocorrelation(wav_files{1,i}, output, calc, priority, x_axes, Lcor, Ncor, t_start, t_end);
    if strcmp(output, 'display') ~= 1
      for x = 1:Ncor
        A = buildXLSMatrix(A, param.name{x}, param.duration, param.rate, param.ripple(x), param.sigma(x), param.ex(x), param.t_diff(x));
      end
    end
  end
end
%save to excel file
if strcmp(output, 'display') ~= 1
  writeEXCEL(excel_path, A);
end
%----------------------------------------

toc
disp('finished');
