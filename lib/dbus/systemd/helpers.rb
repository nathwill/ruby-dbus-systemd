module DBus
  module Systemd
    module Helpers
      def system_bus
        DBus::SystemBus.instance
      end

      def session_bus
        DBus::SessionBus.instance
      end

      def map_array(array, map)
        mapped = {}

        array.each_with_index do |item, index|
          mapped[map.key(index)] = item
        end

        mapped
      end

      module_function :system_bus, :session_bus, :map_array
    end
  end
end
