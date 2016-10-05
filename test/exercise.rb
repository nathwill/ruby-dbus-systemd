#!/usr/bin/env ruby
#
# test script for running the code
# through its paces in the vagrant box.
# 
# must be run as privileged user!
#

require 'dbus/systemd'

#
# Hostnamed
#
hostnamed = DBus::Systemd::Hostnamed.new

test_domain = 'mydomain.localdomain'

hostnamed.SetHostname(test_domain, false)
raise "Bad hostnamed result unless" unless hostnamed.properties['Hostname'] == test_domain
puts "successfully changed hostname"

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
# Localed
#
localed = DBus::Systemd::Localed.new
raise 'Bad localed result' unless localed.properties['VConsoleKeymap'] == 'us'
puts "successfully checked locale properties"

#
# Logind
#
logind = DBus::Systemd::Logind::Manager.new
raise "oh noes" unless logind.properties['KillUserProcesses'] == false
puts "successfully checked logind manager properties"

seat = logind.seat(logind.seats.first[:id])
raise "bad seat result" unless seat.properties['CanTTY'] == true
puts "successfully checked seat"

user = logind.user(logind.users.first[:id])
raise "bad user result" unless user.properties['Name'] == 'vagrant'
puts "successfully checked user"

session = logind.session(logind.sessions.first[:id])
raise "bad session result" unless user.properties['Name'] == 'vagrant'
puts "successfully checked session"

#
# Networkd
#
networkd = DBus::Systemd::Networkd::Manager.new
raise "bad networkd result" unless networkd.properties['OperationalState'] == 'routable'
puts "successfully checked networkd mgr properties"

networkd_link = DBus::Systemd::Networkd::Link.new(1)
raise "bad networkd link result" unless networkd_link.properties['AdministrativeState'] == 'unmanaged'
puts "successfully checked networkd link properties"

#
# Resolved
#
resolved = DBus::Systemd::Resolved::Manager.new
raise "bad resolved proxy" unless resolved.respond_to?(:ResolveHostname)
puts "successfully checked resolved mgr"

resolved_link = DBus::Systemd::Resolved::Link.new(1)
raise "bad resolved link proxy" unless resolved_link.respond_to?(:SetDNS)
puts "successfully checked resolved link"

# 
# Timedated
#
timedated = DBus::Systemd::Timedated.new
timedated.SetTimezone('America/Los_Angeles', false)
raise "bad timedated result" unless timedated.properties['Timezone'] == 'America/Los_Angeles'
puts "successfully set timezone"

#
# Manager
#
mgr = DBus::Systemd::Manager.new
raise "bad mgr result" unless mgr.properties['Virtualization'] == 'oracle'
puts "successfully checked manager properties"

unit = mgr.unit('sshd.service')
raise "bad unit result" unless unit.properties['SubState'] == 'running'
puts "successfully checked unit state"

# systemd's too damn fast... need to find another way to test this, maybe with a slower service
#job = mgr.get_job_by_object_path(unit.Restart('replace').first)
#raise "bad job result" unless job.properties['JobType'] == 'restart'
# puts "successfully checked job status"

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
