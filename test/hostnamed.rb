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
