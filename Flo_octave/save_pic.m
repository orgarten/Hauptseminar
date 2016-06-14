function [ ack ] = save_pic(fig, path_res, i)

path = strcat(path_res, '.png');
%print(path, '-dpng')
set(fig, 'Visible', 'on');
saveas(fig, path);
set(fig, 'Visible', 'off');
ack = strcat(path, ' is saved as a picture');
end