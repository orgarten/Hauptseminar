function [correlation, param] = audiocorrelation(path, output, calc, priority, x_axes, Lcor, Ncor, t_start, t_end)

  %-------------------------------------------------------------------------------
  %% CODE
  if strcmp(priority, 'time')
      Ncor = 1;
  end

  % load part of the signal from given path
  %  row --> channel
  [data, rate] = readAudio(path, t_start, t_end, Lcor, Ncor, priority); 

  %% devide into Ncor parts
  [channel_a, channel_b] = splitChannel(data, Lcor, Ncor, priority);

  % deleting last sample if amount odd
  len = length(channel_a(1,:));
  if mod(len,2) == 1
    channel_a(:,length(channel_a)) = [];
    channel_b(:,length(channel_b)) = [];
  end

  %% extracting name from path
  if strcmp(output, 'save')  
    str1 = regexp(path, '\\' ,'split');
    str2 = regexp(str1{length(str1)}, '\.' , 'split');
  end

  for i = 1:Ncor
    % completing name
    if strcmp(output, 'save')
      name = strcat(str2{1}, '_res(', num2str(i), ')');
      path_res = strcat('.\RESULTS\', name, '\', name, '_', num2str(length(channel_a)));
      mkdir('.\RESULTS', name);
    end
    
    if strcmp(calc, 'xcorr')
      %% correlate  in time
      [correlation(i,:), lags ] = xcorr(channel_a(i,:), channel_b(i,:),'coeff');
   
    else
      % in frequency 
      correlation(i,:) = freqMult(channel_a(i,:), channel_b(i,:), rate);
      lags = (-length(correlation)/2:1:length(correlation)/2-1);
    end
    
    %% calculate offset between channels
    [~,I(i)] = max(abs(correlation(i,:)));
    lagDiff(i) = lags(I(i));
    timeDiff(i) = lagDiff(i)/rate;

    %% calculate ripple factor
    ripple(i) = calc_ripple(correlation(i,:));
    
    % sort correlation
    sorted(i,:) = sort(abs(correlation(i,:)), 'descend');
    % fit a exp curve to sorted correlation
    [reg_exp(i,:), ex(i)] = calc_reg(sorted(i,:), rate, 1, 1);
    
    % create envelope by AM-Demodulation
    [envelope(i,:), index_en(i)] = calc_envelope(correlation(i,:), length(channel_a), rate);
    % fit a gaussian curve to envelope
    [reg_gauss(i,:), sigma(i)] = calc_reg(envelope(i,:), rate, index_en(i), 0);

    %% plot
    % puts string together, that is shown in the plot
    txt = build_txt(ripple(i), sigma(i), ex(i), lagDiff(i), timeDiff(i), rate, x_axes);
    
    % shows the figure
    fig = plotTandF(channel_a(i,:), channel_b(i,:), correlation(i,:), envelope(i,:), reg_gauss(i,:), sorted(i,:), reg_exp(i,:), x_axes, rate, txt, output);
    
    
    param = [param; [ripple(i) sigma(i) ex(i) timeDiff(i)]];
    
    %% save results
    if strcmp(output, 'save')
      ack = save_data(fig, channel_a, channel_b, rate, path_res, i)    
    end
  end
end

