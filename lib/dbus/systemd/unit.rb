require_relative 'method_missing'
require_relative 'manager'

module DBus
  module Systemd
    class Unit
      INTERFACE = 'org.freedesktop.systemd1.Unit'

      include MethodMissing

      attr_accessor :object

      def initialize(name, manager = Manager.new)
        unit_path = manager.object.GetUnit(name).first
        @object = manager.service.object(unit_path)
                                 .tap(&:introspect)
      end
    end
  end
end
