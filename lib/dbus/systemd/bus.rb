require 'dbus'

module DBus
  module Systemd
    module Bus
      def system_bus
        DBus::SystemBus.instance
      end

      def session_bus
        DBus::SessionBus.instance
      end

      module_function :system_bus, :session_bus
    end
  end
end
