function [ FigHandle ] = plotTandF( channel_a, channel_b, correlation, envelope, regression, sorted, reg_exp, x_axis, rate, txt, output, name)
%PLOTTANDF Summary of this function goes here
%   Detailed explanation goes here

shift = -(length(correlation)-1)/2:1:(length(correlation)-1)/2;
shift_t = 1:1:length(channel_a);

if strcmp(x_axis, 'seconds') == 1
  scale = 1/rate; 
  shift = shift .* scale;
  shift_t = shift_t .* scale;
end

FigHandle = figure('Name', name);
set(FigHandle, 'Position', [100, 100, 1000, 800]);
if strcmp(output, 'save_all') == 1
  set(FigHandle, 'Visible', 'off');
end

ax1 = subplot(3, 2,1);
plot(shift_t, channel_a);
title('channel a');
set(gca, 'XLim', [shift_t(1) shift_t(length(shift_t))]);
if strcmp(x_axis, 'seconds') == 1
  xlabel(['time/s']);
else
  xlabel(['samples']);
end

ax2 = subplot(3, 2,2);
plot(shift_t, channel_b);
title('channel b');
set(gca, 'XLim', [shift_t(1) shift_t(length(shift_t))]);
if strcmp(x_axis, 'seconds') == 1
  xlabel(['time/s']);
else
  xlabel(['samples']);
end

if length(envelope) < length(shift)
  envelope(length(envelope)+1) = 0;
end

ax3 = subplot(3, 2, [3,4]);
plot(shift, correlation, shift, envelope, 'r-.', 'LineWidth', 1, shift, regression, 'k--', 'LineWidth', 1);
title('correlation normalized to max');
legend('correlation', 'envelope', 'regression');
if strcmp(x_axis, 'seconds') == 1
  xlabel(['time/s']);
else
  xlabel(['samples']);
end
set(gca, 'XLim', [shift(1) shift(length(shift))]);
limits_x = get(gca, 'XLim');
limits_y = get(gca, 'YLim');
if strcmp(output, 'save_all')
  text(limits_x(1) * 7/8 , limits_y(1) + (limits_y(2)-limits_y(1))/12, txt);
else
  text(limits_x(1) * 7/8 , limits_y(1) + (limits_y(2)-limits_y(1))/8, txt);
end

%figure('Name', name)
ax4 = subplot(3, 2, [5,6]);
plot(shift_t, sorted, shift_t, reg_exp); 
title('sorted correlation with exp-fit');
legend('sorted', 'fit');
xlabel(['time/s']);



end