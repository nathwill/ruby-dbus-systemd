#
# Copyright (C) 2016 Nathan Williams <nath.e.will@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
# the Software, and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
# FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
# IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#
require_relative 'manager'
require_relative 'mixin'

module DBus
  module Systemd
    class Unit
      # the unit dbus interface
      INTERFACE = 'org.freedesktop.systemd1.Unit'.freeze

      include Mixin::MethodMissing
      include Mixin::Properties

      #
      # create a new unit object for interfacing with systemd units
      #
      # @param name [String] unit name
      # @param manager [DBus::Systemd::Manager] systemd manager object
      def initialize(name, manager = Manager.new)
        unit_path = manager.GetUnit(name).first
        @object = manager.service.object(unit_path)
        @object.default_iface = INTERFACE
        @object.introspect
      end
    end
  end
end

require_relative 'unit/automount'
require_relative 'unit/device'
require_relative 'unit/mount'
require_relative 'unit/path'
require_relative 'unit/scope'
require_relative 'unit/service'
require_relative 'unit/slice'
require_relative 'unit/snapshot'
require_relative 'unit/socket'
require_relative 'unit/swap'
require_relative 'unit/target'
require_relative 'unit/timer'
