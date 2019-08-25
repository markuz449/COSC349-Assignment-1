# -*- mode: ruby -*-
# vi: set ft=ruby :

# A Vagrantfile to set up three VMs, a webserver, a database server and an image processing server,
# connected together using an internal network with manually-assigned
# IP addresses for the VMs.

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"

  # set up the database server
  config.vm.define "dbserver" do |dbserver|
    dbserver.vm.hostname = "dbserver"

    dbserver.vm.network "private_network", ip: "192.168.2.12"

    dbserver.vm.synced_folder ".", "/vagrant", owner: "vagrant", group: "vagrant", mount_options: ["dmode=775,fmode=777"]
    
    dbserver.vm.provision "shell", path: "installs/build_database.sh"
  end

  # set up the webserver
  config.vm.define "webserver" do |webserver|
    webserver.vm.hostname = "webserver"
    
    webserver.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
    
    webserver.vm.network "private_network", ip: "192.168.2.11"

    webserver.vm.synced_folder ".", "/vagrant", owner: "www-data", group: "www-data", mount_options: ["dmode=775,fmode=777"]

    webserver.vm.provision "shell", path: "installs/build_webserver.sh"
  end

  # set up the image server
  config.vm.define "imgserver" do |imgserver|
    imgserver.vm.hostname = "imgserver"

    imgserver.vm.network "private_network", ip: "192.168.2.13"

    imgserver.vm.synced_folder ".", "/vagrant", owner: "vagrant", group: "vagrant", mount_options: ["dmode=775,fmode=777"]
    
    imgserver.vm.provision "shell", path: "installs/build_image.sh"
  end
end

#  LocalWords:  webserver bionic64
