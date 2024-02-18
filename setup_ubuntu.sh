#!/bin/bash

log_file="setup_log.txt"

# Function for logging
log() {
    echo "$(date) - $1" | tee -a "$log_file"
}

# Function to check if a package is installed
is_package_installed() {
    dpkg-query -l "$1" &>/dev/null
}

log "Updating package list"
sudo apt-get update | tee -a "$log_file"

log "Upgrading existing packages"
sudo apt-get upgrade -y | tee -a "$log_file"

log "Installing xbindkeys for additional mouse keys"
sudo apt-get install -y xbindkeys x11-utils xdotool xautomation | tee -a "$log_file"

content=$(cat <<'EOL'
"xte 'keydown Control_L' 'key c' 'keyup Control_L'"
b:9

"xte 'keydown Control_L' 'key v' 'keyup Control_L'"
b:8
EOL
)

log "Writing content to .xbindkeysrc in the home directory of user mabdelawal"
echo "$content" > ~/.xbindkeysrc

log "Restarting xbindkeys"
killall xbindkeys
xbindkeys

log "Creating Projects folder"
mkdir Projects

log "Installing Google Cloud SDK"
if ! is_package_installed google-cloud-sdk; then
	sudo apt-get install apt-transport-https ca-certificates gnupg curl sudo
	curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
	echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
	sudo apt-get update && sudo apt-get install google-cloud-cli
else
    log "Google Cloud SDK is already installed"
fi

log "Installing pgAdmin"
if ! is_package_installed pgadmin4-desktop; then
    curl -fsS https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo gpg --dearmor -o /usr/share/keyrings/packages-pgadmin-org.gpg
    sudo sh -c 'echo "deb [signed-by=/usr/share/keyrings/packages-pgadmin-org.gpg] https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list && apt update'
    sudo apt install -y pgadmin4-desktop | tee -a "$log_file"
else
    log "pgAdmin is already installed"
fi

log "Installing Docker and Docker Compose"
if ! is_package_installed docker-ce; then
    sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    apt-cache policy docker-ce
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin | tee -a "$log_file"
else
    log "Docker is already installed"
fi

log "Installing Safe Eyes"
if ! is_package_installed safeeyes; then
    sudo add-apt-repository -y ppa:slgobinath/safeeyes
    sudo apt update
    sudo apt install -y safeeyes | tee -a "$log_file"
else
    log "Safe Eyes is already installed"
fi

log "Installing GDAL"
if ! is_package_installed gdal-bin; then
    sudo apt install -y gdal-bin python3-gdal | tee -a "$log_file"
else
    log "GDAL is already installed"
fi

log "Installing PyCharm Community Edition"
if ! command -v pycharm-community &>/dev/null; then
    sudo snap install pycharm-community --classic | tee -a "$log_file"
else
    log "PyCharm Community Edition is already installed"
fi

log "Installing Visual Studio Code"
if ! command -v code &>/dev/null; then
    sudo snap install code --classic | tee -a "$log_file"
else
    log "Visual Studio Code is already installed"
fi


log "Installing Curl"
if ! is_package_installed curl; then
    sudo apt install -y curl | tee -a "$log_file"
else
    log "Curl is already installed"
fi


log "Installing NodeJS"
if ! is_package_installed nodejs; then
	sudo apt-get update && sudo apt-get install -y ca-certificates gnupg
	curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
	NODE_MAJOR=20
	echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
	sudo apt-get update && sudo apt-get install nodejs -y
else
    log "NodeJS is already installed"
fi

log "Installing GNOME Tweaks"
if ! is_package_installed gnome-tweaks; then
    sudo apt install -y gnome-tweaks | tee -a "$log_file"
else
    log "GNOME Tweaks is already installed"
fi


log "Installing GNOME Shell Extensions"
if ! is_package_installed gnome-extensions; then
    sudo apt install -y gnome-shell-extensions | tee -a "$log_file"
else
    log "GNOME Shell Extensions is already installed"
fi


log "Installing pip3 % python dev tools"
if ! is_package_installed pip3; then
    sudo apt install -y python3-pip | tee -a "$log_file"
    sudo apt install -y python3-dev build-essential python3-django  | tee -a "$log_file"
else
    log "pip3 is already installed"
fi

log "Installing psycopg2 binary"
pip3 install psycopg2-binary | tee -a "$log_file"


# my favorite wallpaper changerpyD
sudo apt update && sudo apt install variety


log "Setup completed successfully. Check $log_file for details."
