require_relative '../unit'

module DBus::Systemd
  class Unit
    class Automount < Unit
      INTERFACE = 'org.freedesktop.systemd1.Service'
    end
  end
end
