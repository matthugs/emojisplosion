#!/bin/zsh

input_file_name_raw=${1?"gotta' gimme'a file name, yo"};
# "path/to/file.blah" -> "file.blah"
input_file_name="$(basename "${input_file_name_raw}")"
# "file.blah" -> "file-transparent.png"
file_name_to_output="${input_file_name%.*}.png"


convert ${input_file_name} -fuzz 05% -transparent white ${file_name_to_output}
