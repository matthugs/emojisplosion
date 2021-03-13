#!/bin/sh

# Function for downloading all emoji from a particular slack organization
# Usage:
# - navigate to <$your_organization>.slack.com/customize/emoji
# - authenticate as appropriate
# - open developer tools and navigate to the "Network" tab & reload the page
# - use the search "emoji.list" or "emoji.adminList" to isolate a single request
# - right click on that request > Copy > Copy response
# - save that in a file
# - execute `./download-emoji.sh name-of-the-file-you-saved
#
# Dependencies: jq https://stedolan.github.io/jq/
#               wget
#               perl

function download_all_emoji_here() {
    jq ".emoji" emoji-list.json | # pull out the list of emoji from json
        sed '1d;$d' | # discard the first and last lines ('{' & '}', respectively)
        perl -n -e  '/"([a-zA-Z_-]+)": "(https:\/\/emoji.slack-edge.com\/T[A-Z0-9]{8}\/[a-zA-Z_-]+\/[a-g0-9]{16}\.(jpg|png|gif))/ && print "$2 $1.$3\n"' | # strip out only lines that point to image files, and rearrange them as "whole_url emoji_name.extension_at_end_of_url"
        xargs -n1 | # process line-by-line
        while read a; read b; do wget -nd -O - $a > ./$b ; done; # download from the url, save to file name
}

download_all_emoji_here "${1}"
