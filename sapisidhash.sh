#!/bin/sh
set -o nounset
epoch=${epoch:-$(date +%s)}
url=${url:-https://www.youtube.com}
case "${1:-x}" in
    -h|--header) printf 'authorization: SAPISIDHASH %s_%s' \
        "$epoch" \
        "$(printf "%s %s %s" "$epoch" "$sapisid" "$url" \
            | sha1sum \
        | sed 's/[ -]*//g')";;
    *) printf "%s %s %s" "$epoch" "$sapisid" "$url" \
        | sha1sum \
        | sed 's/[ -]*//g'
esac
