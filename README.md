Table of contents
=================
   * [Table of contents](#table-of-contents)
   * [Overview](#overview)
   * [Setup Staging](#setup-staging)
   * [Troubleshooting](#troubleshooting)
   
## Overview
This is a tool to measure your download speed statistics over time. It runs on a local sqlite database for simplicity.
I'm planning to run this on a cron and build a for a parent node to poll the children for data.

## Setup Staging
>### Get the .git file, do nothing else
>```
>git clone -n git@github.com:bmsandoval/gofastcom.git --depth 1
>cd gofastcom
>```

>### Get a local copy of master
>```
>git fetch
>git pull
>```

>### Run program on loop, watching for updates to master repo
>```
>. ./scripts/run.sh
>```

## Troubleshooting
sandman at hunin in ~/projects/gofastcom on master
$ ./app
./app: /lib/x86_64-linux-gnu/libc.so.6: version `GLIBC_2.28' not found (required by ./app)