function [ channel_a, channel_b ] = splitChannel( data, Lcor, Ncor, priority )
%PREPAREDATA splits stereo channels 
%   saves the stereo channels in the matrices depending on priority

if strcmp(priority,'length') == 1
    for i = 1:1:Ncor
        channel_a(i,:) = data(1, 1+(i-1)*Lcor:1:i*Lcor);
        channel_b(i,:) = data(2, 1+(i-1)*Lcor:1:i*Lcor);
    end
else
    Ncor = 1;
    channel_a = data(1,:);
    channel_b = data(2,:);
end

end

