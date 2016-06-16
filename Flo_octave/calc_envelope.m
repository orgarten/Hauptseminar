function [envelope, index_en] = calc_envelope (correlation, N_len, rate)
% calculates the envelope by using AM-Demodulation
% cutoff-frequency in Herz
f_c = 20*rate/length(correlation);

% building lowpass filter
fil = zeros(1, length(correlation));
if 2*round(N_len*f_c/rate) >= length(fil)
  fil(1:length(fil)) = 1;
else
  fil(1:round(N_len*f_c/rate)) = 1;
  fil(round(length(fil)-N_len*f_c/rate):length(fil)) = 1;
end

% multiplication in frequency domain 
corr_f = fft(abs(correlation)); 
corr_lp = corr_f .* fil;
envelope = real(ifft(corr_lp));
[~,index_en] = max (envelope);


%figure
%plot(1:1:length(fil), fil);
%figure
%plot(1:1:length(corr_f), corr_f);
%set(gca, 'YLim', [-1.5 1.5]);
%figure
%plot(1:1:length(corr_lp), corr_lp);
%set(gca, 'YLim', [-1.5 1.5]);

end