require_relative 'helpers'
require_relative 'mixin'

module DBus
  module Systemd
    class Timedated
      NODE = '/org/freedesktop/timedate1'
      INTERFACE = 'org.freedesktop.timedate1'

      include Mixin::MethodMissing
      include Mixin::Properties

      attr_reader :service

      def initialize(bus = Helpers.system_bus)
        @service = bus.service(INTERFACE)
        @object = @service.object(NODE)
                          .tap(&:introspect)
      end
    end
  end
end
