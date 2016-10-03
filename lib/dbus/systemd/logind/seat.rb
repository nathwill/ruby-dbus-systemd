require_relative '../mixin'
require_relative 'manager'

module DBus
  module Systemd
    module Logind
      class Seat
        INTERFACE = 'org.freedesktop.login1.Seat'

        include Systemd::Mixin::MethodMissing

        def initialize(id, manager = Manager.new)
          seat_path = manager.GetSeat(id).first
          @object = manager.service.object(seat_path)
                                   .tap(&:introspect)
        end
      end
    end
  end
end
