require_relative '../unit'

module DBus::Systemd
  class Unit
    class Target < Unit
      INTERFACE = 'org.freedesktop.systemd1.Target'
    end
  end
end
