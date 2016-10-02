require_relative '../unit'

module DBus::Systemd
  class Unit
    class Timer < Unit
      INTERFACE = 'org.freedesktop.systemd1.Unit'
    end
  end
end
