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
    INTERFACE = 'org.freedesktop.systemd1'

    class Manager
      NODE = '/org/freedesktop/systemd1'
      INTERFACE = 'org.freedesktop.systemd1.Manager'

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
      }

      JOB_INDICES = {
        id: 0,
        unit: 1,
        type: 2,
        state: 3,
        object_path: 4,
        unit_object_path: 5
      }

      include Mixin::MethodMissing
      include Mixin::Properties

      attr_reader :service

      def initialize(bus = Systemd::Helpers.system_bus)
        @service = bus.service(Systemd::INTERFACE)
        @object = @service.object(NODE)
                          .tap(&:introspect)
      end

      def units
        self.ListUnits.first.map { |u| map_unit(u) }
      end

      def unit(name)
        Unit.new(name, self)
      end

      def get_unit_by_object_path(path)
        obj = @service.object(path)
                      .tap(&:introspect)
        Unit.new(obj.Get(Unit::INTERFACE, 'Id').first, self)
      end

      def map_unit(unit_array)
        Helpers.map_array(unit_array, UNIT_INDICES)
      end

      def jobs
        self.ListJobs.first.map { |j| map_job(j) }
      end

      def job(id)
        Job.new(id, self)
      end

      def get_job_by_object_path(path)
        obj = @service.object(path)
                      .tap(&:introspect)
        Job.new(obj.Get(Job::INTERFACE, 'Id').first, self)
      end

      def map_job(job_array)
        Helpers.map_array(job_array, JOB_INDICES)
      end
    end
  end
end
