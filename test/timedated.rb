#!/usr/bin/env ruby
#
# test script for running the code
# through its paces in the vagrant box.
#
# must be run as privileged user!
#

require 'dbus/systemd'

#
# Timedated
#
timedated = DBus::Systemd::Timedated.new
timedated.SetTimezone('America/Los_Angeles', false)
raise "bad timedated result" unless timedated.properties['Timezone'] == 'America/Los_Angeles'
puts "successfully set timezone"
