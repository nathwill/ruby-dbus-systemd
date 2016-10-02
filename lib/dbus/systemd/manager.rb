require_relative '../systemd'
require_relative 'unit'
require_relative 'method_missing'

module DBus
  module Systemd
    class Manager
      OBJECT = '/org/freedesktop/systemd1'
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

      include MethodMissing

      attr_accessor :service, :object

      def initialize(bus = Systemd.system_bus)
        @service = bus.service(Systemd::INTERFACE)
        @object = @service.object(OBJECT)
                          .tap(&:introspect)
      end

      def units
        @object.ListUnits.first.map { |u| map_unit(u) }
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
        mapped = {}

        unit_array.each_with_index do |item, index|
          mapped[UNIT_INDICES.key(index)] = item
        end

        mapped
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
        mapped = {}

        job_array.each_with_index do |item, index|
          mapped[JOB_INDICES.key(index)] = item
        end

        mapped
      end
    end
  end
end
