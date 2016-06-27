function [ correlation ] = freqMult( channel_a, channel_b, rate)
%FREQMULT correlates channels by multiplication in frequency
%   convolution in time equals multiplication in frequency domain

t=0;

if t ==1
f_channel_a = fftshift(fft(channel_a));
f_channel_b = fftshift(fft(channel_b));
correlation = f_channel_a .* conj(f_channel_b);
correlation_t = ifftshift(ifft(correlation));

correlation = real(correlation_t)/(length(correlation_t)/rate)^2;

else
f_channel_a = fft(channel_a);
f_channel_b = fft(channel_b);
correlation = f_channel_a .* conj(f_channel_b);
correlation_t = ifft(correlation);

correlation(:,1:length(correlation_t)/2) = correlation_t(:,length(correlation_t)/2+1:length(correlation_t));
correlation(:,length(correlation_t)/2+1:length(correlation_t)) = correlation_t(:,1:length(correlation_t)/2);

correlation = real(correlation)/max(correlation);
% norm to length^2 --> (length(correlation)/rate)^2
end

end

