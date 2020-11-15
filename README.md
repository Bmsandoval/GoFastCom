Table of contents
=================
   * [Table of contents](#table-of-contents)
   * [Overview](#overview)
   * [Setup Staging](#setup-staging)
   * [Rpi Configuration](#rpi-configuration)
   * [Troubleshooting](#troubleshooting)
   
------------------------------------------------------------------------
## Overview
This is a tool to measure your download speed statistics over time. It runs on a local sqlite database for simplicity.
I'm planning to run this on a cron and build a for a parent node to poll the children for data.

------------------------------------------------------------------------
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

------------------------------------------------------------------------
## RPI Configuration
>### Setup sd card
>These instructions are based on a Mac
>* flash a sd card. BalenaEtcher works pretty good on mac
>* setup ssh before pi's first boot, create an empty 'ssh' file in the base directory of your sd card
>```
>touch /Volumes/boot/ssh
>```
>* optionally setup your wifi network before startup in a similar way
>```
>echo << 'EOF' > /Volumes/boot/wpa_supplicant.conf
>country=us
>update_config=1
>ctrl_interface=/var/run/wpa_supplicant
>
>network={
> scan_ssid=1
> ssid="MyNetworkSSID"
> psk="Pa55w0rd1234"
>}
>EOF
>```

>### Boot the pi and login
>* now boot your pi with the sd card in. I'd recommend watching your router for a new ip to pop up
>* once you know the ip, ssh into the pi `ssh pi@ip_address`. reminder that the initial user is `pi` and password is `raspberry`

>### Install Docker
>* follow the instructions on `https://docs.docker.com/engine/install/ubuntu/`
>* be sure to follow the instructions for the right architecture (armhf for raspberry pi)
>* the following is roughly the commands required as of 11/14/2020
>```
>sudo apt-get update && \
>sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y && \
>curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && \
>sudo add-apt-repository "deb [arch=armhf] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
>sudo apt-get update && \
>sudo apt-get install docker-ce docker-ce-cli containerd.io -y && \
>docker -v
>```
>```
>curl -fSLs https://get.docker.com | sudo sh
>```

>### Setup Git
>* create your ssh keys by running `ssh-keygen -t rsa` and just hit enter a few times
>* add the new ssh keys to your keychaing `ssh-add ~/.ssh/id_rsa`
>* now make sure to add the id_rsa.pub to your github's ssh keys
>* should now be able to clone this repo `git clone git@github.com:bmsandoval/gofastcom.git clone`

------------------------------------------------------------------------
## Troubleshooting
sandman at hunin in ~/projects/gofastcom on master
$ ./app
./app: /lib/x86_64-linux-gnu/libc.so.6: version `GLIBC_2.28' not found (required by ./app)