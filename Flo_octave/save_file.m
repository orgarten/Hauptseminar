function [] = save_file(channel_a, channel_b, rate, path_res)

path_wav = strcat(path_res, '.wav');
data = [channel_a; channel_b]';
audiowrite(path_wav, data, rate);

disp(strcat(path_res, ' is saved as wav'));