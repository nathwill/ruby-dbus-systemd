#!/usr/bin/env ruby
#
# test script for running the code
# through its paces in the vagrant box.
#
# must be run as privileged user!
#

require 'dbus/systemd'

#
# Resolved
#
resolved = DBus::Systemd::Resolved::Manager.new
raise "bad resolved proxy" unless resolved.respond_to?(:ResolveHostname)
puts "successfully checked resolved mgr"

resolved_link = DBus::Systemd::Resolved::Link.new(1)
raise "bad resolved link proxy" unless resolved_link.respond_to?(:SetDNS)
puts "successfully checked resolved link"
