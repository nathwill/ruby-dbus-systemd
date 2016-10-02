require_relative '../unit'

module DBus::Systemd
  class Unit
    class Device < Unit
      INTERFACE = 'org.freedesktop.systemd1.Device'
    end
  end
end
