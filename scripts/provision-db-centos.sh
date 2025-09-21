#!/bin/bash
sudo dnf update -y
# Enable MySQL module
sudo dnf module enable -y mysql:8.4
sudo dnf install -y @mysql:8.4/server
# Start and enable MySQL
sudo systemctl enable --now mysqld
sleep 5
# Secure MySQL root user
sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'root'; FLUSH PRIVILEGES;"

# Create app user
sudo mysql -uroot -proot -e "CREATE USER IF NOT EXISTS 'appuser'@'%' IDENTIFIED BY 'app123';"
sudo mysql -uroot -proot -e "GRANT ALL PRIVILEGES ON *.* TO 'appuser'@'%' WITH GRANT OPTION;"
sudo mysql -uroot -proot -e "FLUSH PRIVILEGES;"

# Updated path to database folder
SQL_DIR="/vagrant/database"
if [ -f "$SQL_DIR/create-table.sql" ]; then
  sudo mysql -uroot -proot < "$SQL_DIR/create-table.sql"
else
  echo "Le fichier $SQL_DIR/create-table.sql n'existe pas."
fi

if [ -f "$SQL_DIR/insert-demo-data.sql" ]; then
  sudo mysql -uroot -proot < "$SQL_DIR/insert-demo-data.sql"
else
  echo "Le fichier $SQL_DIR/insert-demo-data.sql n'existe pas."
fi