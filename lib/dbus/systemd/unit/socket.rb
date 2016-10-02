require_relative '../unit'

module DBus::Systemd
  class Unit
    class Socket < Unit
      INTERFACE = 'org.freedesktop.systemd1.Socket'
    end
  end
end
