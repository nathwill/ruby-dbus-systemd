require_relative '../systemd/mixin'
require_relative 'manager'

module DBus
  module Importd
    class Transfer
      INTERFACE = 'org.freedesktop.import1.Transfer'

      include DBus::Systemd::Mixin::MethodMissing

      def initialize(id, manager = Manager.new)
        @object = manager.service.object("#{Importd::Node}/transfer/_#{id}")
                                 .tap(&:introspect)
      end
    end
  end
end
