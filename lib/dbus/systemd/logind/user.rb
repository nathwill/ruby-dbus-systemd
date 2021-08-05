# frozen_string_literal: true

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
      class User
        # logind user object dbus interface
        INTERFACE = 'org.freedesktop.login1.User'

        include Systemd::Mixin::MethodMissing
        include Systemd::Mixin::Properties

        #
        # create new logind user dbus proxy object
        #
        # @param id [Integer] logind user id
        # @param manager [DBus::Systemd::Logind::Manager] logind manager object
        def initialize(id, manager = Manager.new)
          user_path = manager.GetUser(id).first
          @object = manager.service.object(user_path)
          @object.default_iface = INTERFACE
          @object.introspect
        end
      end
    end
  end
end
