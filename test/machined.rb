#!/usr/bin/env ruby
#
# test script for running the code
# through its paces in the vagrant box.
#
# must be run as privileged user!
#

require 'dbus/systemd'

#
# Importd
#

bus = DBus::Systemd::Helpers.system_bus

importd = DBus::Systemd::Importd::Manager.new(bus)
machined = DBus::Systemd::Machined::Manager.new(bus)

loop = DBus::Main.new
loop << bus

transfer_id = nil

importd.on_signal('TransferRemoved') do |id, path, result|
  puts "Finished transfer: #{id}; Result: #{result}"
  loop.quit if id == transfer_id
end

source = 'https://dl.fedoraproject.org/pub/fedora/linux/releases/24/CloudImages/x86_64/images/Fedora-Cloud-Base-24-1.2.x86_64.raw.xz'
img_name = 'Fedora-24'
verify_mode = 'no'
force_dl = true

transfer_id = importd.PullRaw(source, img_name, verify_mode, force_dl).first

loop.run

raise "no image found" unless machined.images.detect { |img| img[:name] == img_name }
puts "found image"
