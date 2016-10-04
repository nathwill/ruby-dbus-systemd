# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  config.vm.box = 'bento/fedora-24'
  config.vm.box_check_update = true

  config.vm.provision 'shell', inline: <<-SHELL
    dnf install -y git ruby systemd-container btrfs-progs
    gem instal bundler --no-document
  SHELL
end
