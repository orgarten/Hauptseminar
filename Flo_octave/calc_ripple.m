function [ ripple ] = calc_ripple(correlation)
% this function calculates the ripple(peakyness) of the crosscorrelation

%% calculate energy in entire correlation

W_ges = sum(correlation.^2);

%% calculate energy in top 5% 

top = prctile(abs(correlation), 95); 


W = 0; 


for i = 1:length(correlation)
  if abs(correlation(i)) > top
    W = W + correlation(i)^2;
  end
end

W_top = W;

%% calculate ripple
ripple = W_top/W_ges;

end