require_relative '../helpers'
require_relative '../mixin'
require_relative 'link'

module DBus
  module Systemd
    module Resolved
      INTERFACE = 'org.freedesktop.resolve1'

      class Manager
        NODE = '/org/freedesktop/resolve1'
        INTERFACE = 'org.freedesktop.resolve1.Manager'

        include Systemd::Mixin::MethodMissing

        attr_reader :service

        def initialize(bus = Systemd::Helpers.system_bus)
          @service = bus.service(Resolved::INTERFACE)
          @object = @service.object(NODE)
                            .tap(&:introspect)
        end
      end
    end
  end
end
