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
#
# See docs for full API description:
# https://www.freedesktop.org/wiki/Software/systemd/dbus/
#
require_relative 'helpers'
require_relative 'mixin'
require_relative 'unit'
require_relative 'job'

module DBus
  module Systemd
    # systemd dbus interface
    INTERFACE = 'org.freedesktop.systemd1'.freeze

    class Manager
      # systemd manager object dbus node path
      NODE = '/org/freedesktop/systemd1'.freeze

      # systemd manager dbus interface
      INTERFACE = 'org.freedesktop.systemd1.Manager'.freeze

      # index map of unit array returned by ListUnits
      UNIT_INDICES = {
        name: 0,
        description: 1,
        load_state: 2,
        active_state: 3,
        sub_state: 4,
        following: 5,
        object_path: 6,
        job_id: 7,
        job_type: 8,
        job_object_path: 9
      }.freeze

      # index map of job array returned by ListJobs
      JOB_INDICES = {
        id: 0,
        unit: 1,
        type: 2,
        state: 3,
        object_path: 4,
        unit_object_path: 5
      }.freeze

      include Mixin::MethodMissing
      include Mixin::Properties

      # @return [DBus::Service]
      # @api private
      attr_reader :service

      #
      # Create a systemd manager dbus proxy object
      #
      # @param bus [DBus::SystemBus, DBus::SessionBus] bus instance
      def initialize(bus = Systemd::Helpers.system_bus)
        @service = bus.service(Systemd::INTERFACE)
        @object = @service.object(NODE)
                          .tap(&:introspect)
      end

      #
      # get an array of mapped units/unit properties
      #
      # @return [Array] array of mapped unit property hashes
      def units
        self.ListUnits.first.map { |u| map_unit(u) }
      end

      #
      # get a unit dbus proxy object by name
      #
      # @param name [String] unit name (e.g. 'sshd.service')
      # @return [DBus::Systemd::Unit] unit dbus proxy object
      def unit(name)
        Unit.new(name, self)
      end

      #
      # get unit object by dbus node path
      #
      # @param path [String] unit dbus node path
      # @return [DBus::Systemd::Unit] unit dbus proxy object
      def get_unit_by_object_path(path)
        obj = @service.object(path)
                      .tap(&:introspect)
        Unit.new(obj.Get(Unit::INTERFACE, 'Id').first, self)
      end

      #
      # map unit array from ListUnits to property hash
      #
      # @param unit_array [Array] array as returned from ListUnits
      # @return [Hash] unit property hash
      def map_unit(unit_array)
        Helpers.map_array(unit_array, UNIT_INDICES)
      end

      #
      # array of jobs from ListJobs mapped to property hashes
      #
      # @return [Array] array of job property hashes
      def jobs
        self.ListJobs.first.map { |j| map_job(j) }
      end

      #
      # get job by id
      #
      # @param id [Integer] job id
      # @return [DBus::Systemd::Job] job dbus proxy object
      def job(id)
        Job.new(id, self)
      end

      #
      # get job by dbus node path
      #
      # @param path [String] job dbus node path
      # @return [DBus::Systemd::Job] job dbus proxy object
      def get_job_by_object_path(path)
        obj = @service.object(path)
                      .tap(&:introspect)
        Job.new(obj.Get(Job::INTERFACE, 'Id').first, self)
      end

      #
      # map job array from ListJobs to property hash
      #
      # @param job_array [Array] job property array as returned by ListJobs
      # @return [Hash] mapped job property hash
      def map_job(job_array)
        Helpers.map_array(job_array, JOB_INDICES)
      end
    end
  end
end
