#!/bin/sh
set -o errexit -o nounset -o noclobber
dir=$(CDPATH='' cd -- "$(dirname -- "$0")/.." && pwd); cd "$dir"

epoch=1683649061
sapisid=WIXg9jS3ZYhyie1A/A9Q_UBopN0dhn8SUV
export epoch sapisid

## -----------------
expect=f4ae537fb5255d5dae836642acf286153deac819
result=$(./sapisidhash.sh)
[ "$result" = "$expect" ] || {
    echo >&2 "Bad result $result - expected $expect"; exit 1; } 

## -----------------
hash="$expect"
expect='authorization: SAPISIDHASH 1683649061_f4ae537fb5255d5dae836642acf286153deac819'
result=$(./sapisidhash.sh --header)
[ "$result" = "$expect" ] || {
    echo >&2 "Bad result $result - expected $expect"; exit 1; } 

echo "Completed $(basename "$0" .sh)"
