function [ channel_a, channel_b ] = splitChannel( data, Lcor, Ncor, priority)
%PREPAREDATA splits stereo channels 
%   saves the stereo channels in the matrices depending on priority

if strcmp(priority,'time') == 1
  Lcor = length(data)/Ncor;
end

for i = 1:Ncor
  channel_a(i,:) = data(1, 1+(i-1)*Lcor:1:i*Lcor);
  channel_b(i,:) = data(2, 1+(i-1)*Lcor:1:i*Lcor);
end

end

