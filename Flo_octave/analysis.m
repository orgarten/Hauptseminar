function [ripple, sigma, ex, area, lagDiff, timeDiff, envelope, reg_gauss, sorted, reg_exp] = analysis(correlation, lags, rate, x_axes)
 
  %% calculate offset between channels
  [~,I] = max(abs(correlation));
  lagDiff = lags(I);
  timeDiff = lagDiff/rate;

  % calculate ripple factor
  ripple = calc_ripple(correlation);
  
  % sort correlation and calulate normalized area 
  sorted = sort(abs(correlation), 'descend');
  area = sum(sorted)/length(sorted);
  % fit a exp curve to sorted correlation
  [reg_exp, ex] = calc_reg(sorted, rate, 1, 1);
  ex = ex * length(correlation);
  
  % create envelope by AM-Demodulation
  [envelope, index_en] = calc_envelope(correlation, length(correlation), rate);
  % fit a gaussian curve to envelope
  [reg_gauss, sigma] = calc_reg(envelope, rate, index_en, 0);
  if strcmp(x_axes, 'seconds')
    sigma = sigma/rate;
  end
end