require_relative '../systemd/method_missing'
require_relative 'manager'

module DBus
  module Importd
    class Transfer
      INTERFACE = 'org.freedesktop.import1.Transfer'

      include DBus::Systemd::MethodMissing

      def initialize(id, manager = Manager.new)
        @object = manager.service.object("#{Importd::Node}/transfer/_#{id}")
                                 .tap(&:introspect)
      end
    end
  end
end
