#!/bin/sh
echo "Configuring"
export PATH=/bin:/sbin:/usr/bin:/usr/sbin
sudo domainname analytics.nokia.com
sudo cp -fv /vagrant_data/hosts /etc/hosts
sudo cp -fv /vagrant_data/environment /etc/environment
wget http://apt-enterprise.puppetlabs.com/puppetlabs-enterprise-release-extras_1.0-2_all.deb
sudo dpkg -i puppetlabs-enterprise-release-extras_1.0-2_all.deb
sudo apt-get update
