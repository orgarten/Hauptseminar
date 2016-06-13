function [ ripple ] = calc_ripple(correlation, N)
% this function calculates the ripple(peakyness) of the crosscorrelation

%% calculate energy in entire correlation
W = zeros(N,1);

for i = 1:length(correlation(1,:))
  W(:,1) = W(:,1) + correlation(:,i).^2;
end

W_ges = W;

%% calculate energy in top 5% 
for i = 1:N
  top(i,1) = abs(prctile(correlation(i,:), 95)); 
end

W = zeros(N,1); 

for k = 1:N
  for i = 1:length(correlation(1,:))
    if abs(correlation(k,i)) > top(k)
      W(k) = W(k) + correlation(k,i)^2;
    end
  end
end

W_top = W;

%% calculate ripple
ripple = W_top./W_ges;

end