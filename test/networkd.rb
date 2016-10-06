#!/usr/bin/env ruby
#
# test script for running the code
# through its paces in the vagrant box.
#
# must be run as privileged user!
#

require 'dbus/systemd'

#
# Networkd
#
networkd = DBus::Systemd::Networkd::Manager.new
raise "bad networkd result" unless networkd.properties['OperationalState'] == 'routable'
puts "successfully checked networkd mgr properties"

networkd_link = DBus::Systemd::Networkd::Link.new(1)
raise "bad networkd link result" unless networkd_link.properties['AdministrativeState'] == 'unmanaged'
puts "successfully checked networkd link properties"
