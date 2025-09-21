#!/bin/bash
# Provision Web Server Ubuntu 22.04

# Update system
sudo apt-get update -y
sudo apt-get upgrade -y

# Install Nginx
sudo apt-get install -y nginx git

# Enable and start Nginx
sudo systemctl enable nginx
sudo systemctl start nginx

# Clone sample website if /var/www/html is empty
if [ -z "$(ls -A /var/www/html)" ]; then
    sudo git clone https://github.com/startbootstrap/startbootstrap-agency.git /var/www/html
fi

# Set permissions for synced folder
sudo chown -R www-data:www-data /var/www/html
sudo chmod -R 755 /var/www/html
