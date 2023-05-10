#!/usr/bin/env sh
# shellcheck disable=SC2039  # local keyword is fine, actually
set -o errexit -o nounset -o noclobber
dir=$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd); cd "$dir"

# action=BLACKLIST_ACTION_UNBLOCK
action=BLACKLIST_ACTION_BLOCK
kidGaiaId=${kidGaiaId:?}
if [ "${channelId:-ABC}" = ABC ]; then
    channelId=$(./get_channel_id.sh -r)
fi 
channelSlug=${channelSlug:-YouTube}
graftUrl="https://www.youtube.com/@$channelSlug/about"

# replace existing values from template
jq_script="$(cat <<-EOF
    .kidGaiaId |= "$kidGaiaId"
    | .context.client.originalUrl |= "$graftUrl"
    | .context.client.mainAppWebInfo.graftUrl |= "$graftUrl"
    | .items[0].externalChannelId |= "$channelId"
    | .items[0].action |= "$action"
EOF
)"

payload=$(jq -c "$jq_script" <./request.json)
cookies=$(cat ./cookies)
sapisid=$(printf "%s" "$cookies" | sed -En 's/(^SAPISID|.+; SAPISID)=([^;]*);.*/\2/p')
. ./credentials
# authorization will work even if hard-coded, but best not to do that by default
authorization=$(sapisid=$sapisid ./sapisidhash.sh --header)

printf "%s" "$payload" | \
curl 'https://www.youtube.com/youtubei/v1/kids/update_blacklist?key='"$key"'&prettyPrint=false' \
  -H 'accept-language: en-US,en;q=0.9' \
  -H "$authorization" \
  -H "cookie: $(cat ./cookies)" \
  -H 'referer: '"$graftUrl" \
  -H "x-client-data: $x_client_data" \
  -H "x-goog-authuser: $x_goog_authuser" \
  -H "x-goog-visitor-id: $x_goog_visitor_id" \
  --config ./conf.0.curlrc \
  --config ./conf.ua.curlrc \
  --config ./conf.x.curlrc \
  --data @- \
  -o /dev/null

echo "${action##*_} $channelSlug for $kidGaiaId"
