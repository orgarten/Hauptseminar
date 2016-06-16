function [txt] = build_txt(ripple, sigma, ampl, lagDiff, timeDiff, rate, x_axis)
% puts together the String that is shown in the plot

line_1 = sprintf('ripple = %f \nampl = %f \n', ripple, ampl);
if strcmp(x_axis, 'seconds') == 1
  line_2 = sprintf('timeDiff = %f s \n\\sigma = %f s', timeDiff, sigma/rate);
else
  line_2 = sprintf('samplesDiff = %d samples \n\\sigma = %d samples', lagDiff, sigma);
end
txt = strcat(line_1, line_2);