function [ ans ] = writeEXCEL(filename, content)
%WRITEEXCEL writes matrix to excel sheet
  xlswrite(filename,content);
end;