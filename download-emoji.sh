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
    jq -rj '.emoji | to_entries[] | (.value, " ", .key, ".", (.value | capture("(?<extension>jpg|png|gif)$").extension), "\n")' "${1}" |
        xargs -n1 | # process line-by-line
        while read a; read b; do wget -nd -O - $a > ./$b ; done; # download from the url, save to file name
}

download_all_emoji_here "${1}"
