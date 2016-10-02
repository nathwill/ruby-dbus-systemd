require_relative '../unit'

module DBus::Systemd
  class Unit
    class Mount < Unit
      INTERFACE = 'org.freedesktop.systemd1.Mount'
    end
  end
end
