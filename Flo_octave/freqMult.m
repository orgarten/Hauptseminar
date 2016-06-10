function [ correlation ] = freqMult( channel_a, channel_b )
%FREQMULT correlates channels by multiplication in frequency
%   convolution in time equals multiplication in frequency domain

f_channel_a = fft(channel_a);
f_channel_b = fft(channel_b);
correlation = f_channel_a .* conj(f_channel_b);
correlation_f = ifft(correlation);
correlation(:,1:1:length(correlation_f(1,:))/2) = correlation_f(:,length(correlation_f(1,:))/2+1:1:length(correlation_f(1,:)));
correlation(:,length(correlation_f(1,:))/2+1:1:length(correlation_f(1,:))) = correlation_f(:,1:1:length(correlation_f(1,:))/2);

end

