function [ ripple ] = calc_ripple(correlation)
% this function calculates the ripple(peakyness) of the crosscorrelation

%% calculate energy in entire correlation
W = 0;

for i = 1:length(correlation(1,:))
  W = W + correlation(1,i)^2;
end

W_ges = W;

%% calculate energy in top 5% 

top = abs(prctile(correlation, 95)); 

W = 0; 

for i = 1:length(correlation(1,:))
  if abs(correlation(1,i)) > top
    W = W + correlation(1,i)^2;
  end
end

W_top = W;

%% calculate ripple
ripple = W_top/W_ges;

end