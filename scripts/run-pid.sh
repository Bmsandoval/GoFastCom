#!/usr/bin/env bash

GOFASTCOM_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

## Run this script on startup or when you want to start the staging server
# TODO : elegantly handle a bad commit

# trap ctrl-c and call ctrl_c()
trap gofastcom_close INT
trap gofastcom_close EXIT

function gofastcom_close() {
  kill "${GOFASTCOM_PID}"
}

GOFASTCOM_PID=""
while :
do
  HEADHASH=$(git rev-parse HEAD)
  UPSTREAM=$(git ls-remote origin -h refs/heads/master)
  UPSTREAMPARSED=$(echo $UPSTREAM | cut -d' ' -f1)

  if [ "$HEADHASH" != "$UPSTREAMPARSED" ]; then
    git fetch
    git pull
    kill "${GOFASTCOM_PID}"
    GOFASTCOM_PID=""
    exec "${GOFASTCOM_SCRIPT_DIR}"
  fi
  if [ "${GOFASTCOM_PID}" == "" ]; then
    ./app &
    GOFASTCOM_PID=$!
  fi
  sleep 5m
done
