require_relative "systemd/version"
require_relative "systemd/manager"
require_relative "systemd/unit"
require_relative "systemd/job"

require "dbus"

module DBus
  module Systemd
    INTERFACE = 'org.freedesktop.systemd1'

    def system_bus
      DBus::SystemBus.instance
    end

    def session_bus
      DBus::SessionBus.instance
    end

    module_function :system_bus, :session_bus
  end
end
