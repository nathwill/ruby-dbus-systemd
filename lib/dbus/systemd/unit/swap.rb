require_relative '../unit'

module DBus::Systemd
  class Unit
    class Swap < Unit
      INTERFACE = 'org.freedesktop.systemd1.Swap'
    end
  end
end
