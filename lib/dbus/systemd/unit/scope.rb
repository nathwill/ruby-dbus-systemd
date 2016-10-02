require_relative '../unit'

module DBus::Systemd
  class Unit
    class Scope < Unit
      INTERFACE = 'org.freedesktop.systemd1.Scope'
    end
  end
end
