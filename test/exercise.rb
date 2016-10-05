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

#
# Importd
#
importd_mgr = DBus::Systemd::Importd::Manager.new

transfer = importd_mgr.PullRaw('https://dl.fedoraproject.org/pub/fedora/linux/releases/24/CloudImages/x86_64/images/Fedora-Cloud-Base-24-1.2.x86_64.raw.xz', 'Fedora-24', 'no', false)

importd_transfer = DBus::Systemd::Importd::Transfer.new(importd_mgr.map_transfer(transfer)[:id])
raise "Bad importd transfer result" unless importd_transfer.properties['Type'] == 'pull-raw'

#
# Localed
#
localed = DBus::Systemd::Localed.new
raise 'Bad localed result' unless localed.properties['VConsoleKeymap'] == 'us'

#
# Logind
#
logind = DBus::Systemd::Logind::Manager.new
raise "oh noes" unless logind.properties['KillUserProcesses'] == false

seat = logind.seat(logind.seats.first[:id])
raise "bad seat result" unless seat.properties['CanTTY'] == true

user = logind.user(logind.users.first[:id])
raise "bad user result" unless user.properties['Name'] == 'vagrant'

session = logind.session(logind.sessions.first[:id])
raise "bad session result" unless user.properties['Name'] == 'vagrant'

#
# Networkd
#
networkd = DBus::Systemd::Networkd::Manager.new
raise "bad networkd result" unless networkd.properties['OperationalState'] == 'routable'

networkd_link = DBus::Systemd::Networkd::Link.new(1)
raise "bad networkd link result" unless networkd_link.properties['AdministrativeState'] == 'unmanaged'

#
# Resolved
#
resolved = DBus::Systemd::Resolved::Manager.new
raise "bad resolved proxy" unless resolved.respond_to?(:ResolveHostname)

resolved_link = DBus::Systemd::Resolved::Link.new(1)
raise "bad resolved link proxy" unless resolved_link.respond_to?(:SetDNS)

# 
# Timedated
#
timedated = DBus::Systemd::Timedated.new
timedated.SetTimezone('America/Los_Angeles', false)

raise "bad timedated result" unless timedated.properties['Timezone'] == 'America/Los_Angeles'

#
# Manager
#
mgr = DBus::Systemd::Manager.new
raise "bad mgr result" unless mgr.properties['Virtualization'] == 'oracle'

unit = mgr.unit('sshd.service')
raise "bad unit result" unless unit.properties['SubState'] == 'running'

# systemd's too damn fast... need to find another way to test this, maybe with a slower service
#job = mgr.get_job_by_object_path(unit.Restart('replace').first)
#raise "bad job result" unless job.properties['JobType'] == 'restart'


#
# Machined
#
machined_mgr = DBus::Systemd::Machined::Manager.new
raise "uh oh" unless machined_mgr.respond_to?(:GetMachine)

img = machined_mgr.image('Fedora-24')
img.Clone('test', false)

res = machined_mgr.RegisterMachine('test', '', 'nathan', 'container', Process.pid, '')
raise "register machine failure" unless res.first == '/org/freedesktop/machine1/machine/test'