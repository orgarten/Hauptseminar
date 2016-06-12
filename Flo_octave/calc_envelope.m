function [envelope, fil] = calc_envelope (correlation, N, rate)
% calculates the envelope by using AM-Demodulation
f_c = 43900;
fil = zeros(1, length(correlation));
if round(length(correlation)/2 + 1 + N*f_c/rate) >= length(correlation)
  fil(1:1:length(fil)) = 1;
else
  fil(round(length(correlation)/2 + 1 - N*f_c/rate) :1: round(length(correlation)/2 + 1 + N*f_c/rate)) = 1;
end
one(1:1:length(fil)) = 1;
fil = xor(fil, one);

%figure
%plot(1:1:length(fil), fil);
corr_f = fft(abs(correlation)); 

%corr_sw(:,1:1:length(corr_f(1,:))/2) = corr_f(:,length(corr_f(1,:))/2+1:1:length(corr_f(1,:)));
%corr_sw(:,length(corr_f(1,:))/2+1:1:length(corr_f(1,:))) = corr_f(:,1:1:length(corr_f(1,:))/2);
corr_sw = corr_f;

%figure
%plot(1:1:length(corr_sw), corr_sw);
%set(gca, 'YLim', [-1.5 1.5]);

corr_lp = corr_sw .* fil;

%figure
%plot(1:1:length(corr_lp), corr_lp);
%set(gca, 'YLim', [-1.5 1.5]);

envelope = ifft(corr_lp);

end