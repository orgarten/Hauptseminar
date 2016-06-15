function [ ack ] = save_data(fig, channel_a, channel_b, rate, path_res, i)

path_pic = strcat(path_res, '.svg');
%print(path_pic, '-dpng')
set(fig, 'Visible', 'on');
saveas(fig, path_pic);
set(fig, 'Visible', 'off');

path_wav = strcat(path_res, '.wav');
data = [channel_a; channel_b]';
audiowrite(path_wav, data, rate);

ack = strcat(path_res, ' is saved as picture and wav');
end