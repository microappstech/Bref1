# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # ===== Variables =====
  WEB_IP        = ENV['WEB_IP'] || "192.168.56.10"
  DB_IP         = ENV['DB_IP']  || "192.168.56.20"
  HOST_DB_PORT  = (ENV['HOST_DB_PORT'] || "3307").to_i

  # ===== Web Server (Ubuntu 22.04) =====
  config.vm.define "web-server" do |web|
    web.vm.box = "ubuntu/jammy64"
    web.vm.hostname = "web-server"

    # Public network (DHCP)
    web.vm.network "public_network"

    # Private network (communication inter-VM)
    web.vm.network "private_network", ip: WEB_IP

    # Sync folder local -> guest
    web.vm.synced_folder "./website", "/var/www/html",
      owner: "www-data", group: "www-data"

    # VirtualBox provider configuration
    web.vm.provider "virtualbox" do |vb|
      vb.name = "web-server"
      vb.memory = 1024
      vb.cpus = 1
    end

    # Provisioning script
    web.vm.provision "shell", path: "scripts/provision-web-ubuntu.sh"
  end
  # ===== Database Server (CentOS 9) =====
    config.vm.define "db-server" do |db|
      db.vm.box = "generic/centos9s"
  
      # Sync the entire project directory to /vagrant
      db.vm.synced_folder ".", "/vagrant", type: "rsync"

      # Private network
      db.vm.network "private_network", ip: DB_IP

      # Port forwarding for MySQL access from host
      db.vm.network "forwarded_port", guest: 3306, host: HOST_DB_PORT, auto_correct: true

      # VirtualBox provider configuration
      db.vm.provider "virtualbox" do |vb|
        vb.name = "db-server"
        vb.memory = 1024
        vb.cpus = 1
      end

      # Provisioning script
      db.vm.provision "shell", path: "scripts/provision-db-centos.sh"
    end

  
end
