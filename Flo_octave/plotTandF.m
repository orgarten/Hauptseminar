function [ output_args ] = plotTandF( channel_a, channel_b, correlation_t, correlation_f, envelope, x_axis, rate)
%PLOTTANDF Summary of this function goes here
%   Detailed explanation goes here

shift = -(length(correlation_t)-1)/2:1:(length(correlation_t)-1)/2;
shift_f = -(length(correlation_f)-1)/2:1:(length(correlation_f)-1)/2;
shift_t = 1:1:length(channel_a);

if strcmp(x_axis, 'seconds') == 1
  scale = 1/rate; 
  shift = shift .* scale;
  shift_f = shift_f .* scale;
  shift_t = shift_t .* scale;
end

figure;

ax1 = subplot(2,2,1);
plot(shift_t, channel_a);
title('channel a');
if strcmp(x_axis, 'seconds') == 1
  xlabel(['time/s']);
else
  xlabel(['samples']);
end

ax2 = subplot(2,2,2);
plot(shift_t, channel_b);
title('channel b');
if strcmp(x_axis, 'seconds') == 1
  xlabel(['time/s']);
else
  xlabel(['samples']);
end

if length(envelope) < length(shift)
  envelope(length(envelope)+1) = 0;
end

ax3 = subplot(2, 2, [3,4]);
plot(shift, correlation_t, shift, envelope, 'r--');
title('correlation_t');
if strcmp(x_axis, 'seconds') == 1
  xlabel(['time/s']);
else
  xlabel(['samples']);
end
limits = get(gca, 'XLim');

%ax2 = subplot(2, 1, 2);
%plot(shift_f, correlation_f);
%set(gca, 'XLim', limits); 
%title('correlation_f');
%if strcmp(x_axis, 'seconds') == 1
%  xlabel(['time/s']);
%else
%  xlabel(['samples']);
%end

end