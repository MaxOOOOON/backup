# -*- mode: ruby -*-
# vi: set ft=ruby :
file_to_disk = './disk1.vdi'

Vagrant.configure("2") do |config|

    config.vm.define "backup-server" do |server|
      config.vm.box = 'centos/8'
        
    #   server.vm.network "forwarded_port", guest: 80, host: 8081
      server.vm.network :private_network, ip: "10.0.0.30"
      server.vm.hostname = "backup-server"

      server.vm.provider "virtualbox" do |vb|
        vb.memory = "2048"
        vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        vb.customize ['createhd', '--filename', file_to_disk, '--size', 2000]
        vb.customize ["storagectl", :id, "--name", "SATA", "--add", "sata" ]
        vb.customize ['storageattach', :id, '--storagectl', 'SATA', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', file_to_disk]
      end
    end
    
      config.vm.define "client" do |client|
        client.vm.box = 'centos/8'

        client.vm.network :private_network, ip: "10.0.0.31"
        client.vm.hostname = "client"

        client.vm.provider :virtualbox do |vb|
          vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        end
      end
    
    #   config.vm.provision "ansible" do |ansible|
    #     ansible.playbook = "playbook.yml"
    #     ansible.become = "true"
    #   end


    end