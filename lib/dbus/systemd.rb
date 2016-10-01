require_relative "dbus/systemd/version"
require_relative "dbus/systemd/interface"
require_relative "dbus/systemd/manager"
require_relative "dbus/systemd/unit"
require_relative "dbus/systemd/job"

require "dbus"

module Dbus
  module Systemd
    def system_bus
      DBus::SystemBus.instance
                     .service(INTERFACE)
    end

    def session_bus
      DBus::SessionBus.instance
                      .service(INTERFACE)
    end

    module_function :system_bus, :session_bus
  end
end
