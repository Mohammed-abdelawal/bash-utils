#!/bin/bash

# Update package list and upgrade existing packages
sudo apt update
sudo apt upgrade

# Install xbindkeys for my additional mouse keys
sudo apt install xbindkeys x11-utils xdotool xautomation

content=$(cat <<'EOL'
"xte 'keydown Control_L' 'key c' 'keyup Control_L'"
b:9

"xte 'keydown Control_L' 'key v' 'keyup Control_L'"
b:8
EOL
)

# Use echo to write the content to .xbindkeysrc in the home directory of user mabdelawal
echo "$content" > ~/.xbindkeysrc

killall xbindkeys
xbindkeys


# gcloud installing
sudo apt-get install apt-transport-https ca-certificates gnupg curl sudo
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
sudo apt-get update && sudo apt-get install google-cloud-cli

# pg admin
curl -fsS https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo gpg --dearmor -o /usr/share/keyrings/packages-pgadmin-org.gpg
sudo sh -c 'echo "deb [signed-by=/usr/share/keyrings/packages-pgadmin-org.gpg] https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list && apt update'
sudo apt install pgadmin4-desktop


# docker and docker-compose
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

apt-cache policy docker-ce

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin

sudo systemctl status docker
