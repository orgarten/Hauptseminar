% ##############################################
% ########        audio correlator      ########
% ########        of stereo files       ########
% ########      developed for the       ########
% ########          Haupteseminar       ########
% ########      Kommunikationssysteme   ########
% ########          v 1.0               ########
% ##############################################
clear; clc;
pkg load signal;
pkg load optim;
pkg load io;

%work with entire folder or single audiofile (folder/file)
%environment = 'folder';
% path to folder with audiofiles or single file
% works with wav
path = 'RECORDS\lucas';
excel_path = 'RESULTS\data.xlsx';
% results (display/save_param/save_all)
output = 'display';

% calculate correlation with (xcorr/freqMult)
calc = 'freqMult';

% plot in (samples/seconds)
x_axes = 'seconds';

% set priority (time/length)
priority = 'time';

% start of correlation in audio file in seconds
% time -> and durations 
t_start = 8;
t_dur = [0.5 2];

% amount of correlations 
Ncor_init = [4 1];

% length -> length of correlation in samples
Lcor = 8192; 

tic
%----------------------------------------
if strcmp(priority, 'length')
  t_dur = [1];
  Ncor_init(2:length(Ncor_init)) = [];
elseif length(t_dur) ~= length(Ncor_init)
  Ncor_init(1:length(t_dur)) = Ncor_init(1);
  Ncor_init(length(t_dur)+1:length(Ncor_init)) = [];
end

%check whether path is folder or file
%Read Files
if exist(path, 'file') == 2
  wav_files{1,1} = path;
elseif exist(path, 'file') == 7
  wav_files = search_dir(path);
else
  error('path is invalid');
end


%correlate files
A = {};
% loop for different audiofiles
for i = 1:length(wav_files(1,:))
  % loop for different durations of correlation (priority: time)
  for k = 1:length(t_dur)
    t_end = t_start + t_dur(k);
    Ncor = Ncor_init(k);
    
    [rate, duration, Lcor, channel_a, channel_b] = prepare_data(wav_files{1,i}, t_start, t_end, Lcor, Ncor, priority);    
    
    % loop for consecutive correlations
    for n = 1:Ncor
      % building filename and creating folder
      [name, path_res] = build_name(wav_files{1,i}, t_start, duration, n);
      
      % calculates actual correlation
      [correlation, lags] = audiocorrelation(calc, rate, channel_a(n,:), channel_b(n,:));
      
      % all the analysis happens here
      [ripple, sigma, ex, area, lagDiff, timeDiff, envelope, reg_gauss, sorted, reg_exp] = analysis(correlation, lags, rate, x_axes);
      
      % if desired, plot is shown or 
      if strcmp(output, 'save_param') == 0
        % puts string together, that is shown in the plot
        [txt1, txt2] = build_txt(ripple, sigma, lagDiff, timeDiff, ex, area, rate, x_axes);
    
        % shows the figure
        fig = plot_figure(channel_a(n,:), channel_b(n,:), correlation, envelope, reg_gauss, sorted, reg_exp, x_axes, rate, txt1, txt2, output, name);
      end 
      
      % save figure
      if strcmp(output, 'save_all')
        save_figure(fig, path_res);    
      end
      
      % save audiofile
      save_file(channel_a(n,:), channel_b(n,:), rate, path_res); 
      
      % write all parameters to Matrix
      if strcmp(output, 'display') == 0
        A = buildXLSMatrix(A, name, duration, rate, ripple, sigma, ex, area, timeDiff);
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
