#!/bin/bash

# https://www.digitalocean.com/community/tutorials/initial-server-setup-with-ubuntu-18-04
adduser jibe
usermod -aG sudo jibe

ufw allow OpenSSH
ufw enable 

# Move ssh public keys
rsync --archive --chown=jibe:jibe ~/.ssh /home/jibe
