require_relative '../unit'

module DBus::Systemd
  class Unit
    class Snapshot < Unit
      INTERFACE = 'org.freedesktop.systemd1.Snapshot'
    end
  end
end
