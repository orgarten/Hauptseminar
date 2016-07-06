function [name, path_res] = build_name(path, t_start, duration, i)
    
  % extracting name from path
  str1 = regexp(path, '\\' ,'split');
  str2 = regexp(str1{length(str1)}, '\.' , 'split');
  % completing name
  name = strcat(str2{1}, '_(', num2str(t_start+(i-1)*duration), 's)');
  path_res = strcat('.\RESULTS\', name, '\', name, '+', num2str(duration),'s');
  mkdir('.\RESULTS', name);
  name = strcat(name, '+', num2str(duration), 's');

end