#!/usr/bin/env sh
set -o errexit
dir=$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd); cd "$dir"
touch ./cookies ./credentials ./request.json
