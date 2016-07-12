% Little program to measure the time difference of crosscorrelation in time- or frequency-domain

pkg load signal


end_sample = 900000;
schritte = 5000;

times_xcorr = [2:schritte:end_sample];
times_xcorr(:) = 0;

times_freq = [2:schritte:end_sample];
times_freq(:) = 0;

x_achsis = [2:schritte:end_sample];

%length(times_xcorr)
%length(times_freq)
%length(x_achsis)

% prepare_data(path, t_start, t_end, Lcor, Ncor, priority)
[a, fs] = audioread("C:\\Users\\Lucas\\Desktop\\Bullet Train.wav");
i = 1;
for samp = 2:schritte:end_sample
  [rate, duration, Lcor, channel_a, channel_b] = prepare_data("C:\\Users\\Lucas\\Desktop\\Bullet Train.wav",0,0,samp,1,"samples");
  if i == 1
    length([channel_a channel_a])
    length(channel_a)
  endif
  begin1 = tic;
  xcorr([channel_a channel_a], channel_b,'none');
  dur = toc(begin1); 
  times_xcorr(i) = dur;
  begin2 = tic;
  freqMult(channel_a, channel_b, fs);
  dur = toc(begin2); 
  times_freq(i) = dur;
  i = i +1;
endfor

%a = cputime()
%length(times_xcorr)
%length(times_freq)
%length(x_achsis)

fig = figure('Name', "Comparison of the calculation-time");
plot(x_achsis, times_xcorr, x_achsis, times_freq);
grid on;
xlabel('Duration of correlated Signals in samples');
ylabel('Calculation time of the functions in sec');
legend('xcorr(Ovtave)','freqMult(own Code)');
