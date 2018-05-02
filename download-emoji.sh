#!/bin/sh

# Function for downloading all emoji from a particular slack organization
# Usage:
# - navigate to <$your_organization>.slack.com/customize/emoji
# - authenticate as appropriate
# - grab the cookie under the name "d" (using either a browser extension for looking at cookies or the "Application" tab of Chrome dev tools)
# - execute `./download-emoji.sh "paste_the_d_cookie_here" "your_organization_name_as_it_appears_in_the_URL" "page_count_of_emoji_for_your_organization"
#
# Dependencies: pup  https://github.com/ericchiang/pup
#               wget https://savannah.gnu.org/git/?group=wget
#               perl

function download_all_emoji_here() {
    i=1
    while [ $i -le $3 ]; do
        wget -qO- --header "cookie: d=${1}"  "${2}.slack.com/customize/emoji?page=${i}"  | # pull down page html
            pup '.emoji_row .emoji-wrapper attr{data-original}' | # pull emoji from the page html
            perl -n  -e '/T0K6ESZ62\/([^\/]*)\/[^.]*.([a-z]+)$/ && chomp && print "$_ $1.$2\n"'  | # strip out lines of form "whole_url emoji_name.extension_at_end_of_url"
            xargs -n1 | # process line-by-line
            while read a; read b; do wget -nd -O - $a > ./$b ; done; # download from the url, save to file name
        i=$(($i + 1))
    done
}

download_all_emoji_here "${1}" "${2}" "${3}"
