function [correlation, lags] = audiocorrelation(calc, rate, channel_a, channel_b)
  
  if strcmp(calc, 'xcorr')
    %% correlate  in time
    [correlation, lags ] = xcorr(channel_a, channel_b,'coeff');
  else
    % in frequency 
    correlation = freqMult(channel_a, channel_b, rate);
    lags = (-length(correlation)/2:1:length(correlation)/2-1);
  end
end
