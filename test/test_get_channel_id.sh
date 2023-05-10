#!/bin/sh
# shellcheck disable=SC2039,SC2181
dir=$(CDPATH='' cd -- "$(dirname -- "$0")/.." && pwd); cd "$dir"

curl() {
    cat <<-EOF
	<html><head></head><body>
	<link rel="canonical" href="https://www.youtube.com/thing/dGhpcy1pcy1hbi1pZA==?a=b">
	<link rel="canonical" href="https://www.youtube.com/secondmatchisignored">
	<p/>
	</body>
EOF
}
export -f curl
[ "$?" = 0 ] || {
    echo >&2 "Warning: unable to export function. Try running with a different shell";
    exit; }
set -o errexit -o nounset -o noclobber

channelSlug=XYZ
export channelSlug
## -----------------
expect="dGhpcy1pcy1hbi1pZA=="
result=$(./get_channel_id.sh -r)
[ "$result" = "$expect" ] || {
    echo >&2 "Bad result $result - expected $expect"; exit 1; } 

echo "Completed $(basename "$0" .sh)"
