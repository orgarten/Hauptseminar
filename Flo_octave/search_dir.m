function file_names = search_dir (start_path)
%FILE_NAMES this is a function that reads the filenames of a certain path and returns an array with the directory of the contained .wav files

  files = dir(start_path);
  names = {files.name};
  
  for i = 1:1:length(names(1,:))
    wav_pos = strfind(names{1,i}, '.wav');
    if (wav_pos != 0)
      file_names{1,end+1} = strcat(start_path, '\\',names{1,i});
    end
end

end