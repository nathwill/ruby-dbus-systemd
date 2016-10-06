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
importd_mgr = DBus::Systemd::Importd::Manager.new
mm = DBus::Systemd::Machined::Manager.new

if  !mm.images.detect { |i| i[:name] == 'Fedora-24' }
  puts "no image found, checking for transfer in progress"
  if !importd_mgr.transfers.detect { |i| i[:image_name] == 'Fedora-24' }
    puts "no transfer found, starting transfer"
    transfer = importd_mgr.PullRaw('https://dl.fedoraproject.org/pub/fedora/linux/releases/24/CloudImages/x86_64/images/Fedora-Cloud-Base-24-1.2.x86_64.raw.xz', 'Fedora-24', 'no', false)
    puts "started Fedora-24 import :)"
    loop do
      importd_mgr.on_signal('TransferRemoved') do |s|
        puts s
        break
      end
    end
  else
    puts "transfer already in progress"
   end
else
  puts "already downloaded image"
end

unless importd_mgr.transfers.empty?
  if importd_mgr.transfers.detect { |t| t[:image_name] == 'Fedora-24' }
    importd_transfer = DBus::Systemd::Importd::Transfer.new(importd_mgr.map_transfer(transfer)[:id])
    raise "Bad importd transfer result" unless importd_transfer.properties['Type'] == 'pull-raw'
    puts "transfer is in progress :)"
  else
    puts "no transfer in progress"
  end
end

#
# Machined
#

machined_mgr = DBus::Systemd::Machined::Manager.new
raise "uh oh" unless machined_mgr.respond_to?(:GetMachine)
puts "successfully checked machined mgr"

if machined_mgr.images.detect { |i| i[:name] == 'Fedora-24' }
  img = machined_mgr.image('Fedora-24')
  puts "successfully created image proxy"

  if !machined_mgr.images.detect { |i| i[:name] == 'test' }
    img.Clone('test', false)
    puts "successfully cloned image"
  else
    puts "already have a test image"
  end

  if !machined_mgr.machines.detect { |i| i[:name] == 'test' }
    res = machined_mgr.RegisterMachine('test', '', 'dbus-systemd', 'container', Process.pid, '')
    raise "register machine failure" unless res.first == '/org/freedesktop/machine1/machine/test'
    puts "successfully registered machine"

    machine = DBus::Systemd::Machined::Machine.new('test')
    raise "machine trouble" unless machine.GetOSRelease.first['VERSION_ID'] == '24'
    puts "successfully checked machine properties"
  else
    puts "already have a test machine"
  end
end
