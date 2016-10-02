require_relative '../unit'

module DBus::Systemd
  class Unit
    class Path < Unit
      INTERFACE = 'org.freedesktop.systemd1.Path'
    end
  end
end
