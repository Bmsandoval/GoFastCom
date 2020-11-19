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
## RPI (LOCAL) Setup
Must do local setup if you want to use multiple network interfaces
>### Install golang 
>```
>wget https://dl.google.com/go/go1.13.7.linux-armv6l.tar.gz -O go.tar.gz &&
>sudo tar -C /usr/local -xzf go.tar.gz &&
>rm https://dl.google.com/go/go1.13.7.linux-armv6l.tar.gz &&
>cat > ~/.bashrc<< 'EOF'
>export GOPATH=$HOME/go
>export PATH=/usr/local/go/bin:$PATH:$GOPATH/bin
>EOV
>```

>### Setup Network Interface Hopper (firejail)
>* Install Firejail
>```
>sudo apt install firejail
>```
>* Configure it by changing `restricted_network` to `no`
>```
>sudo vim /etc/firejail/firejail.config
>```
>* Check your network interfaces
>```
>ip link show
>```
>* Give it a test
>```
>firejail --dns=8.8.8.8 --noprofile --net=enxa0cec8d9f9c8 ./builds/gof_pi4 measure
>```
>```
>firejail --dns=8.8.8.8 --noprofile --net=eth0 ./builds/gof_pi4 measure
>```



------------------------------------------------------------------------
## RPI (DOCKER) Configuration
>### Setup sd card
>These instructions are based on a Mac
>* flash a sd card. BalenaEtcher works pretty good on mac
>* setup ssh before pi's first boot, create an empty 'ssh' file in the base directory of your sd card
>```
>touch /Volumes/boot/ssh
>```
>* optionally setup your wifi network before startup in a similar way
>```
>cat > /Volumes/boot/wpa_supplicant.conf<< 'EOF'
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
>* that last step just created a sample file. update it as needed
>```
>vim /Volumes/boot/wpa_supplicant.conf
>```

>### Boot the Pi and login
>* now boot your pi with the sd card in. I'd recommend watching your router for a new ip to pop up
>* once you know the ip, ssh into the pi `ssh pi@ip_address`. reminder that the initial user is `pi` and password is `raspberry`
>* before you do anything else, this is a pi's first boot, so change at least the password
>   * this is highly recommended since you will have a ssh key stored on it for your github

>### Setup SSH Keys
>* create your ssh keys by running `ssh-keygen -t rsa` and just hit enter a few times
>* start the ssh agent `eval "$(ssh-agent -s)"`
>* add the new ssh keys to your keychaing `ssh-add ~/.ssh/id_rsa`

>### Setup Git
>* actually install git `sudo apt install git`
>* add the id_rsa.pub to your github's ssh keys
>* should now be able to clone this repo
>   * clone it into your home directory `cd; git clone git@github.com:bmsandoval/gofastcom.git`

>### Install Docker
>* follow the instructions on `https://docs.docker.com/engine/install/ubuntu/`
>* run the following to install docker ce on the pi
>```
>curl -fSLs https://get.docker.com | sudo sh
>```
>* now we need to install docker compose. `sudo apt install docker-compose -y`
>* docker-compose likely won't work at first. Restart the pi `sudo shutdown -r now`
>* now try starting the builder `docker-compose up`

>### Optional Steps
>On boot, pull changes and start the container
>* Create a staging cron file in the cron.d directory
>```
> echo "@reboot cd /gofastcom; ./scripts/run-docker.sh; make run-docker" > /etc/cron.d/pi-boot-cron
>```
>* Give execution rights on the pi-cron job
>```
> chmod 0644 /etc/cron.d/pi-boot-cron
>```
>* Apply pi-cron job
>```
> crontab /etc/cron.d/pi-boot-cron
>```


>### (OPTIONAL) Hot-reload container

------------------------------------------------------------------------
## Troubleshooting
sandman at hunin in ~/projects/gofastcom on master
$ ./app
./app: /lib/x86_64-linux-gnu/libc.so.6: version `GLIBC_2.28' not found (required by ./app)