function [ channel_a, channel_b ] = splitChannel( data, Lcor, Ncor, priority)
%PREPAREDATA splits stereo channels 
%   saves the stereo channels in the matrices depending on priority

if strcmp(priority,'time') == 1
  Lcor = length(data)/Ncor;
end

% the second element og the vector are the cuts for the blocksizes
% example: 5 Blocks, i = 5
% data from the 1+4*Lcor ( End of the fourth Block) to 5*Lcor
% (Lcor is the lenght of the Block in smaples)
for i = 1:Ncor
  channel_a(i,:) = data(1, 1+(i-1)*Lcor:1:i*Lcor);
  channel_b(i,:) = data(2, 1+(i-1)*Lcor:1:i*Lcor);
end

end

