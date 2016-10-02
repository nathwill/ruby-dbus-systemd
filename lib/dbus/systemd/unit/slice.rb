require_relative '../unit'

module DBus::Systemd
  class Unit
    class Slice < Unit
      INTERFACE = 'org.freedesktop.systemd1.Slice'
    end
  end
end
