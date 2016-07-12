function [ ans ] = writeEXCEL(filename, content)
%WRITEEXCEL writes matrix to excel sheet
if exist(filename, 'file') == 0
  content = [{'File' 'duration/s' 'rate/Hz' 'ripple' 'sigma/s' 'exp' 'area' 't_diff'}; content];
  xlswrite(filename,content);
else
  old_content = xlsread(filename);
  xlRange = strcat('A', num2str(size(old_content)(1)+2),':I', num2str(size(old_content)(1)+2+size(content)(1)));
  xlswrite(filename, content, 1, xlRange);
end
end