% this is a function that reads the filenames of a certain path
% and returns an array with the directory of the contained .wav files


function file_names = search_dir (start_path)

files = dir(start_path);
names = {files.name};


leng = length(names(1,:));
    
for i = 1:leng
  wav_pos = strfind(names{1,i}, '.wav');
  if (wav_pos != 0)
    file_names{1,end+1} = strcat(start_path, '\\',names{1,i});
  endif
endfor

endfunction