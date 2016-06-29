function [correlation, param] = audiocorrelation(path, output, calc, priority, x_axis, Lcor, Ncor, t_start, t_end)
  %-------------------------------------------------------------------------------
  %% CODE
  
  % load part of the signal from given path
  %  row --> channel
  [data, rate] = readAudio(path, t_start, t_end, Lcor, Ncor, priority); 

  %% devide into Ncor parts and calculating time
  [channel_a, channel_b] = splitChannel(data, Lcor, Ncor, priority);
  param.duration = length(channel_a(1,:))/rate;

  % deleting last sample if amount odd
  len = length(channel_a(1,:));
  if mod(len,2) == 1
    channel_a(:,length(channel_a)) = [];
    channel_b(:,length(channel_b)) = [];
  end

  %% extracting name from path
  if strcmp(output, 'display') ~= 1 
    str1 = regexp(path, '\\' ,'split');
    str2 = regexp(str1{length(str1)}, '\.' , 'split');
  end

  for i = 1:Ncor
    % completing name
    if strcmp(output, 'display') ~= 1
      name = strcat(str2{1}, '_res(', num2str(i), ')');
      path_res = strcat('.\RESULTS\', name, '\', name, '_', num2str(length(channel_a)));
      mkdir('.\RESULTS', name);
      param.name{i} = strcat(name, '_', num2str(length(channel_a)));
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
    if strcmp(x_axis, 'seconds')
      sigma(i) = sigma(i)/rate;
    end
    
    %% plot
    if strcmp(output, 'save_param') ~= 1
      % puts string together, that is shown in the plot
      txt = build_txt(ripple(i), sigma(i), ex(i), lagDiff(i), timeDiff(i), rate, x_axis);
    
      % shows the figure
      fig = plotTandF(channel_a(i,:), channel_b(i,:), correlation(i,:), envelope(i,:), reg_gauss(i,:), sorted(i,:), reg_exp(i,:), x_axis, rate, txt, output);
    end 
   
    %% save figure
    if strcmp(output, 'display') ~= 1
      save_file(channel_a, channel_b, rate, path_res);   
      if strcmp(output, 'save_all')
        save_figure(fig, path_res);    
      end
    end
  end
  
param.ripple = ripple;
param.sigma = sigma;
param.ex = ex;
param.t_diff = timeDiff;
end

