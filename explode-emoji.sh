#!/bin/bash

input_file_name_raw=${1?"gotta' gimme'a file name, yo"};
# "path/to/file.blah" -> "file.blah"
input_file_name="$(basename "${input_file_name_raw}")"
# "file.blah" -> "file-explosion.gif"
file_name_to_output="${input_file_name%.*}-explosion.gif"

convert -dispose Previous "${input_file_name_raw}" -resize 128x128 -set page +0+0 -set delay 100 explosion.gif -loop 0 "${file_name_to_output}";
