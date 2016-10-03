require_relative '../mixin'
require_relative 'manager'

module DBus
  module Systemd
    module Importd
      class Transfer
        INTERFACE = 'org.freedesktop.import1.Transfer'

        include Systemd::Mixin::MethodMissing

        def initialize(id, manager = Manager.new)
          @object = manager.service.object("#{Manager::NODE}/transfer/_#{id}")
                                   .tap(&:introspect)
        end
      end
    end
  end
end
