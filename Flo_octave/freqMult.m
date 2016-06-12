function [ correlation ] = freqMult( channel_a, channel_b )
%FREQMULT correlates channels by multiplication in frequency
%   convolution in time equals multiplication in frequency domain

f_channel_a = fft(channel_a);
f_channel_b = fft(channel_b);
correlation = f_channel_a .* conj(f_channel_b);
correlation_t = ifft(correlation);
if mod(length(correlation_t),2) == 1
  corr_f(length(correlation_t)) = [];
end
correlation(:,1:1:length(correlation_t(1,:))/2) = correlation_t(:,length(correlation_t(1,:))/2+1:1:length(correlation_t(1,:)));
correlation(:,length(correlation_t(1,:))/2+1:1:length(correlation_t(1,:))) = correlation_t(:,1:1:length(correlation_t(1,:))/2);

end

