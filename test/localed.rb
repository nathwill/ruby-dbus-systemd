#!/usr/bin/env ruby
#
# test script for running the code
# through its paces in the vagrant box.
#
# must be run as privileged user!
#

require 'dbus/systemd'

#
# Localed
#
localed = DBus::Systemd::Localed.new
raise 'Bad localed result' unless localed.properties['VConsoleKeymap'] == 'us'
puts "successfully checked locale properties"
