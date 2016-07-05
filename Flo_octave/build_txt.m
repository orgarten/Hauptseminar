function [txt1, txt2] = build_txt(ripple, sigma, lagDiff, timeDiff, ex, area, rate, x_axis)
% puts together the String that is shown in the plot

line_1 = sprintf('ripple = %f \n', ripple);
if strcmp(x_axis, 'seconds') == 1
  line_2 = sprintf('\\sigma = %f s \ntimeDiff = %f s', sigma, timeDiff);
else
  line_2 = sprintf('\\sigma = %d samples \nsamplesDiff = %d samples', sigma, lagDiff);
end
txt1 = strcat(line_1, line_2);
txt2 = sprintf('exponent = %f \narea = %f', ex, area);