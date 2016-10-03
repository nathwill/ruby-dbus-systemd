require_relative 'helpers'
require_relative 'mixin'

module DBus
  module Systemd
    class Localed
      NODE = '/org/freedesktop/locale1'
      INTERFACE = 'org.freedesktop.locale1'

      include Mixin::MethodMissing

      attr_reader :service

      def initialize(bus = Systemd::Helpers.system_bus)
        @service = bus.service(INTERFACE)
        @object = @service.object(NODE)
                          .tap(&:introspect)
      end
    end
  end
end
