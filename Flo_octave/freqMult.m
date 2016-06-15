function [ correlation ] = freqMult( channel_a, channel_b, rate)
%FREQMULT correlates channels by multiplication in frequency
%   convolution in time equals multiplication in frequency domain

f_channel_a = fft(channel_a);
f_channel_b = fft(channel_b);
correlation = f_channel_a .* conj(f_channel_b);
correlation_t = ifft(correlation);

correlation(:,1:length(correlation_t)/2) = correlation_t(:,length(correlation_t)/2+1:length(correlation_t));
correlation(:,length(correlation_t)/2+1:length(correlation_t)) = correlation_t(:,1:length(correlation_t)/2);
correlation = real(correlation)/(length(correlation)/rate)^2;
end

