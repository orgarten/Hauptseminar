function [ ans ] = writeEXCEL(filename, content)
%WRITEEXCEL writes matrix to excel sheet
  content = [content; {'File' 'ripple' 'sigma' 'dc' 't_diff'}];
  xlswrite(filename,content);
end;