#!/usr/bin/env bash

# I'm wrapping this for better update handling
HEADHASH=$(git rev-parse HEAD)
UPSTREAM=$(git ls-remote origin -h refs/heads/master)
UPSTREAMPARSED=$(echo $UPSTREAM | cut -d' ' -f1)

if [ "$HEADHASH" != "$UPSTREAMPARSED" ]; then
  git fetch
  git pull
fi
