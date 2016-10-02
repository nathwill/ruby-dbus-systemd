require_relative 'method_missing'
require_relative 'manager'

module DBus
  module Systemd
    class Unit
      INTERFACE = 'org.freedesktop.systemd1.Unit'

      include MethodMissing

      def initialize(name, manager = Manager.new)
        unit_path = manager.GetUnit(name).first
        @object = manager.service.object(unit_path)
                                 .tap(&:introspect)
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
