#!/usr/bin/env bash

#GOFASTCOM_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

## Run this script on startup or when you want to start the staging server
# TODO : elegantly handle a bad commit

HEADHASH=$(git rev-parse HEAD)
UPSTREAM=$(git ls-remote origin -h refs/heads/master)
UPSTREAMPARSED=$(echo $UPSTREAM | cut -d' ' -f1)

if [ "$HEADHASH" != "$UPSTREAMPARSED" ]; then
  git fetch
  git pull
fi

make run-docker
