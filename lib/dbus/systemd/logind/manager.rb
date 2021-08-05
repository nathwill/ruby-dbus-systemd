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
require_relative '../helpers'
require_relative '../mixin'
require_relative 'session'
require_relative 'user'
require_relative 'seat'

module DBus
  module Systemd
    module Logind
      # the logind objet dbus service
      SERVICE = 'org.freedesktop.login1'

      class Manager
        # the logind manager object dbus node path
        NODE = '/org/freedesktop/login1'

        # the logind manager object dbus interface
        INTERFACE = 'org.freedesktop.login1.Manager'

        # session array index map as returned by ListSessions
        SESSION_INDICES = {
          id: 0,
          user_id: 1,
          user_name: 2,
          seat_id: 3,
          object_path: 4
        }.freeze

        # user array index map as returned by ListUsers
        USER_INDICES = {
          id: 0,
          name: 1,
          object_path: 2
        }.freeze

        # seat array index map as returned by ListSeats
        SEAT_INDICES = {
          id: 0,
          object_path: 1
        }.freeze

        # inhibitor array index map as returned by ListInhibitors
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

        # @return [DBus::Service]
        # @api private
        attr_reader :service

        #
        # Create a logind manager dbus proxy object
        #
        # @param bus [DBus::SystemBus, DBus::SessionBus] dbus instance
        def initialize(bus = Systemd::Helpers.system_bus)
          @service = bus.service(Logind::SERVICE)
          @object = @service.object(NODE)
          @object.default_iface = INTERFACE
          @object.introspect
        end

        #
        # get mapped list of seats
        #
        # @return [Array] array of mapped seat hashes
        def seats
          self.ListSeats.first.map { |s| map_seat(s) }
        end

        #
        # get seat object
        #
        # @param id [String] seat id (e.g. 'seat0')
        # @return [DBus::Systemd::Logind::Seat] logind seat object
        def seat(id)
          Seat.new(id, self)
        end

        #
        # get seat object from dbus node path
        #
        # @param path [String] seat dbus node path
        # @return [DBus::Systemd::Logind::Seat] logind seat object
        def get_seat_by_path(path)
          obj = @service.object(path)
                        .tap(&:introspect)
          Seat.new(obj.Get(Seat::INTERFACE, 'Id').first, self)
        end

        #
        # map seat array to named field hash
        #
        # @param seat_array [Array] seat array as returned from ListSeats
        # @return [Hash] mapped array as hash
        def map_seat(seat_array)
          Systemd::Helpers.map_array(seat_array, SEAT_INDICES)
        end

        #
        # array of property-mapped seat hashes
        #
        # @return [Array] array of seat-property hashes
        def sessions
          self.ListSessions.first.map { |s| map_session(s) }
        end

        #
        # dbus session object by id
        #
        # @param id [String] session id
        # @return [DBus::Systemd::Logind::Session] logind session object
        def session(id)
          Session.new(id, self)
        end

        #
        # get session object by dbus node path
        #
        # @param path [String] session dbus node path
        # @return [DBus::Systemd::Logind::Session] logind session object
        def get_session_by_path(path)
          obj = @service.object(path)
                        .tap(&:introspect)
          Session.new(obj.Get(Session::INTERFACE, 'Id').first, self)
        end

        #
        # convert session array to mapped hash
        #
        # @param session_array [Array] session array as returned by ListSessions
        # @return [Hash] mapped session property hash
        def map_session(session_array)
          Systemd::Helpers.map_array(session_array, SESSION_INDICES)
        end

        #
        # get logind users
        #
        # @return [Array] array of mapped logind user property hashes
        def users
          self.ListUsers.first.map { |u| map_user(u) }
        end

        #
        # get user dbus object
        #
        # @param id [Integer] user id
        # @return [DBus::Systemd::Logind::User] logind user dbus object
        def user(id)
          User.new(id, self)
        end

        #
        # get user dbus object from dbus node path
        #
        # @param path [String] dbus node path for user
        # @return [DBus::Systemd::Logind::User] logind user dbus object
        def get_user_by_path(path)
          obj = @service.object(path)
                        .tap(&:introspect)
          User.new(obj.Get(User::INTERFACE, 'Id').first, self)
        end

        #
        # convert user array to hash with mapped properties
        #
        # @param user_array [Array] user array as returned by ListUsers
        # @return [Hash] hash with mapped user properties
        def map_user(user_array)
          Systemd::Helpers.map_array(user_array, USER_INDICES)
        end
      end
    end
  end
end
