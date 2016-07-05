function [ ans ] = writeEXCEL(filename, content)
%WRITEEXCEL writes matrix to excel sheet
  content = [{'File' 'duration' 'rate' 'ripple' 'sigma' 'exp' 't_diff'}; content];
  xlswrite(filename,content);
end;