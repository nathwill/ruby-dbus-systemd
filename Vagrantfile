# frozen_string_literal: true

# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  config.vm.box = 'bento/fedora-27'
  config.vm.box_check_update = true

  config.vm.provision 'shell', inline: <<-SHELL
    dnf install -y git ruby rubygem-bundler rubygem-rake systemd-container btrfs-progs
  SHELL
end
