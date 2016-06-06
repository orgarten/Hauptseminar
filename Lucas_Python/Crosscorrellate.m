
tic
file1 = audioread('C:\Users\Lucas\Google Drive\Studium\2016_SS\Hauptseminar Kommunikationssysteme\KKF\Hamletblog.wav');
class(file1);
length(file1(:,1))
%sound(file1(:, 1),44100);
corr = xcorr(file1(:,1) , file1(:, 2) );
corr = corr/max(corr);
plot(corr);
toc