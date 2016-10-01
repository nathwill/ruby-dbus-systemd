require_relative '../systemd'

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

      attr_accessor :bus, :service, :object, :units

      def initialize(bus = DBus::Systemd.system_bus)
        @bus = bus
        refresh
      end

      def get_unit(unit_name)
        Unit.new(unit_name, self)
      end

      def reset_failed
        @object.ResetFailed
      end

      def reload
        @object.Reload
      end

      def reexecute
        @object.Reexecute
      end

      def exit
        @object.Exit
      end

      def reboot
        @object.Reboot
      end

      def power_off
        @object.PowerOff
      end

      def halt
        @object.Halt
      end

      def k_exec
        @object.KExec
      end

      def properties
        @object.GetAll(INTERFACE).first
      end

      def property(prop)
        @object.Get(INTERFACE, prop)
      end

      def refresh
        @service = bus.service(DBus::Systemd::INTERFACE)
        @object = @service.object(OBJECT)
                          .tap(&:introspect)
        @units = @object.ListUnits.first.map { |u| u[UNIT_INDICES[:name]] }
        self
      end
    end
  end
end
