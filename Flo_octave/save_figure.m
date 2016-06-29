function [] = save_figure(fig, path_res)

path_pic = strcat(path_res, '.svg');
%print(path_pic, '-dpng')
set(fig, 'Visible', 'on');
saveas(fig, path_pic);
set(fig, 'Visible', 'off');

disp(strcat(path_res, ' is saved as picture'));
end