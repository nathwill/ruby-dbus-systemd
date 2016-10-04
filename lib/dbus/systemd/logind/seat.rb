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
require_relative '../mixin'
require_relative 'manager'

module DBus
  module Systemd
    module Logind
      class Seat
        # logind seat object dbus interface
        INTERFACE = 'org.freedesktop.login1.Seat'.freeze

        include Systemd::Mixin::MethodMissing
        include Systemd::Mixin::Properties

        #
        # create a new logind seat dbus object
        #
        # @param id [String] logind seat id
        # @param manager [DBus::Systemd::Logind::Manager] logind manager object
        def initialize(id, manager = Manager.new)
          seat_path = manager.GetSeat(id).first
          @object = manager.service.object(seat_path)
                           .tap(&:introspect)
        end
      end
    end
  end
end
