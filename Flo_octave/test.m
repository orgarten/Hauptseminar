clear; clc;
channel_a = [1 2 3 4 5];
channel_b = [6 7 8 9 10];

if mod(length(channel_a(1,:),2) == 1
  channel_a(:,length(channel_a)) = []
  channel_b(:,length(channel_b)) = []
end