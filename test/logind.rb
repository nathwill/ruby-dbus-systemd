#!/usr/bin/env ruby
#
# test script for running the code
# through its paces in the vagrant box.
#
# must be run as privileged user!
#

require 'dbus/systemd'

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
