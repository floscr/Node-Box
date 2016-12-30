#!/usr/bin/env bash
# https://gist.github.com/bhuizi/da8d24223deb2e0d6987e8433aec9dde

# Variables
DBHOST=localhost
DBNAME=nodebox
DBUSER=vagrant
DBPASSWD=vagrant

# Update packages
echo -e "\n--- Updating packages list ---\n"
sudo apt-get update

echo -e "\n--- Install base packages ---\n"
apt-get -y install vim curl build-essential python-software-properties git >> /vagrant/vm_build.log 2>&1

# Install Node
# http://jmfeurprier.com/2015/10/02/how-to-install-node-js-with-ubuntu-and-vagrant-in-a-synced-folder/
echo -e "\n--- Install Node ---\n"
apt-get install -y apache2
apt-get install -y g++
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
apt-get install -y nodejs

# MySQL setup for development purposes ONLY
echo -e "\n--- Install MySQL specific packages and settings ---\n"
debconf-set-selections <<< "mysql-server mysql-server/root_password password $DBPASSWD"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $DBPASSWD"
debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password $DBPASSWD"
debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password $DBPASSWD"
debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password $DBPASSWD"
debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect none"
apt-get -y install mysql-server phpmyadmin >> /vagrant/vm_build.log 2>&1

# Create database
echo -e "\n--- Setting up our MySQL user and db ---\n"
mysql -uroot -p$DBPASSWD -e "CREATE DATABASE $DBNAME" >> /vagrant/vm_build.log 2>&1
mysql -uroot -p$DBPASSWD -e "grant all privileges on $DBNAME.* to '$DBUSER'@'localhost' identified by '$DBPASSWD'" > /vagrant/vm_build.log 2>&1

# Restart Apache
echo -e "\n--- Restarting Apache ---\n"
service apache2 restart >> /vagrant/vm_build.log 2>&1
