#!/usr/bin/env sh
#
set -o errexit -o nounset -o noclobber
dir=$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd); cd "$dir"

action=BLOCK_FOREVER
expected=$(echo '{
  "items": [
    {
      "externalChannelId": "UGFwYXJhenppU25lYWs",
      "action": "BLOCK_FOREVER"
    },
    {
      "externalChannelId": "QW5ub3lpbmdSZWFjdGlvbnM",
      "action": "BLOCK_FOREVER"
    }
  ]
}' | jq -c)
chan=QW5ub3lpbmdSZWFjdGlvbnM

export action chan
# exported variables are available as $ENV values
result=$(jq -c '
  .items[0].action |= $ENV.action
  | .items += [{externalChannelId:$ENV.chan,action:$ENV.action}]
' <items.0.json)
# The += operation requires RHS to be an array for some reason
# The alternative is `.items[.items | length] |= . + {...}` which is worse

[ "$expected" = "$result" ] || {
    printf >&2 "%s\n  %s\n" "Bad result" "$result"
    exit 1; }

echo "Completed $(basename "$0" .sh)"
