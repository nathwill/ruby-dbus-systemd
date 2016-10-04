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
require_relative '../helpers'
require_relative '../mixin'
require_relative 'session'
require_relative 'user'
require_relative 'seat'

module DBus
  module Systemd
    module Logind
      INTERFACE = 'org.freedesktop.login1'.freeze

      class Manager
        NODE = '/org/freedesktop/login1'.freeze
        INTERFACE = 'org.freedesktop.login1.Manager'.freeze

        SESSION_INDICES = {
          id: 0,
          user_id: 1,
          user_name: 2,
          seat_id: 3,
          object_path: 4
        }.freeze

        USER_INDICES = {
          id: 0,
          name: 1,
          object_path: 2
        }.freeze

        SEAT_INDICES = {
          id: 0,
          object_path: 1
        }.freeze

        INHIBITOR_INDICES = {
          what: 0,
          who: 1,
          why: 2,
          mode: 3,
          user_id: 4,
          process_id: 5
        }.freeze

        include Systemd::Mixin::MethodMissing
        include Systemd::Mixin::Properties

        attr_reader :service

        def initialize(bus = Systemd::Helpers.system_bus)
          @service = bus.service(Logind::INTERFACE)
          @object = @service.object(NODE)
                            .tap(&:introspect)
        end

        def seats
          self.ListSeats.first.map { |s| map_seat(s) }
        end

        def seat(id)
          Seat.new(id, self)
        end

        def get_seat_by_path(path)
          obj = @service.object(path)
                        .tap(&:introspect)
          Seat.new(obj.Get(Seat::INTERFACE, 'Id').first, self)
        end

        def map_seat(seat_array)
          Systemd::Helpers.map_array(seat_array, SEAT_INDICES)
        end

        def sessions
          self.ListSessions.first.map { |s| map_session(s) }
        end

        def session(id)
          Session.new(id, self)
        end

        def get_session_by_path(path)
          obj = @service.object(path)
                        .tap(&:introspect)
          Session.new(obj.Get(Session::INTERFACE, 'Id').first, self)
        end

        def map_session(session_array)
          Systemd::Helpers.map_array(session_array, SESSION_INDICES)
        end

        def users
          self.ListUsers.first.map { |u| map_user(u) }
        end

        def user(id)
          User.new(id, self)
        end

        def get_user_by_path(path)
          obj = @service.object(path)
                        .tap(&:introspect)
          User.new(obj.Get(User::INTERFACE, 'Id').first, self)
        end

        def map_user(user_array)
          Systemd::Helpers.map_array(user_array, USER_INDICES)
        end
      end
    end
  end
end
