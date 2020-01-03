#!/bin/bash
# https://www.digitalocean.com/community/tutorials/how-to-install-nginx-on-ubuntu-18-04

# Install nginx
sudo apt update
sudo apt install nginx

# Allow http for nginx
echo "Enable nginx through firewall. Enabling HTTP"
echo "$(sudo ufw app list)"

sudo ufw allow 'Nginx HTTP'

echo "Firewall status"
echo "$(sudo ufw status)"

echo "Status of nginx"
echo "$(systemctl status nginx)"

IP=$(curl -4 icanhazip.com)
echo "Try visiting this website from your browser"
echo "http://$IP"

# More can be done here to setup domain name etc. 
