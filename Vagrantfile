# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/trusty64"

  # Set ip under which the server will be available to your machine
  # Set this in your /etc/hosts file
  config.vm.network "private_network", ip: "192.168.33.10"

  # Name of the box (option)
  config.vm.hostname = "nodebox"

  # Configure Virtual Box
  config.vm.provider "virtualbox" do |v|
    v.memory = 4096
    v.cpus = 4
  end

  # Fast file Syncing
  config.vm.synced_folder "./", "/var/www", type:"nfs", mount_options:["nolock,vers=3,udp,noatime,actimeo=1"]

end
