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

# systemd's too damn fast... need to find another way to test this, maybe with a slower service
#job = mgr.get_job_by_object_path(unit.Restart('replace').first)
#raise "bad job result" unless job.properties['JobType'] == 'restart'
# puts "successfully checked job status"
