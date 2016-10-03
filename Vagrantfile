# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  config.vm.box = 'bento/fedora-24'
  config.vm.box_version = '2.2.9'
  config.vm.box_check_update = true

  config.vm.provision "shell", inline: <<-SHELL
    dnf install -y git ruby rubygem-bundler systemd-container btrfs-progs
  SHELL
end
