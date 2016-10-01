require_relative 'manager'

module DBus
  module Systemd
    class Unit
      def initialize(name, manager = DBus::Systemd::Manager.new)

      end
    end
  end
end
