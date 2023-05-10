#!/usr/bin/env sh
set -o errexit -o nounset -o noclobber
dir=$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd); cd "$dir"

output_prefix=externalChannelId=
slug_prefix=channelSlug=
print_slug=false

getopts() {
    while test "$#" -gt 0; do
        case "${1:-xyz}" in
            -r|--raw) output_prefix=''; slug_prefix='';;
            -s|--show-slug) print_slug=true;; esac
    shift; done
}
getopts "$@"

channelSlug=${channelSlug:?}  # required
graftUrl="https://www.youtube.com/@$channelSlug/about"


canonical=$(curl --silent --show-error "$graftUrl" \
    | grep -Eo -m 1 '<link[^>]+rel="canonical"[^>]+>' \
    | head -n1)
$print_slug && printf "%s%s\n" "$slug_prefix" "$channelSlug"
printf "%s\n" "$canonical" \
    | sed -E 's/.* href="([^"]+).*/\1/' \
    | awk -F/ '{print "'"$output_prefix"'" $NF}' \
    | sed -E 's/\?.*//'

# grab the canonical link tag
# extract the href
# channel ID is everything after the final '/'
# any unexpected query parameters are removed
