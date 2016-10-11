#!/usr/bin/env ruby
#
# test script for running the code
# through its paces in the vagrant box.
#
# must be run as privileged user!
#

require 'dbus/systemd'

#
# Manager
#
mgr = DBus::Systemd::Manager.new
raise "bad mgr result" unless mgr.properties['Virtualization'] == 'oracle'
puts "successfully checked manager properties"

unit = mgr.unit('sshd.service')
raise "bad unit result" unless unit.properties['SubState'] == 'running'
puts "successfully checked unit state"

loop = DBus::Main.new
loop << mgr.bus

job_path = nil

mgr.on_signal('JobRemoved') do |id, path, unit, result|
  puts "Job #{id} completed for #{unit} with result: #{result}"
  loop.quit if path == job_path
end

job_path = mgr.RestartUnit('sshd.service', 'replace').first

loop.run
