function [ output_args ] = plotTandF( correlation_t, correlation_f )
%PLOTTANDF Summary of this function goes here
%   Detailed explanation goes here
shift = -(length(correlation_t)-1)/2:1:(length(correlation_t)-1)/2;
shift_f = -(length(correlation_f)-1)/2:1:(length(correlation_f)-1)/2;

figure;
ax1 = subplot(2, 1, 1);
plot(shift, correlation_t);
title( 'correlation_t');

ax2 = subplot(2, 1, 2);
plot(shift_f, correlation_f);
title('correlation_f');

end

