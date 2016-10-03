require_relative '../mixin'
require_relative 'manager'

module DBus
  module Systemd
    module Machined
      class Machine
        INTERFACE = 'org.freedesktop.machine1.Machine'

        include Systemd::Mixin::MethodMissing
        include Systemd::Mixin::Properties

        def initialize(name, manager = Manager.new)
          machine_path = manager.GetMachine(name).first
          @object = manager.service.object(machine_path)
                                   .tap(&:introspect)
        end
      end
    end
  end
end
