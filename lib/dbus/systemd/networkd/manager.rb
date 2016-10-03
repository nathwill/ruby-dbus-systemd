require_relative '../helpers'
require_relative '../mixin'
require_relative 'link'

module DBus
  module Systemd
    module Networkd
      INTERFACE = 'org.freedesktop.network1'

      class Manager
        NODE = '/org/freedesktop/network1'
        INTERFACE = 'org.freedesktop.network1.Manager'

        include Systemd::Mixin::MethodMissing
        include Systemd::Mixin::Properties

        attr_reader :service

        def initialize(bus = Systemd::Helpers.system_bus)
          @service = bus.service(Networkd::INTERFACE)
          @object = @service.object(NODE)
                            .tap(&:introspect)
        end

        def link(id)
          Link.new(id, self)
        end
      end
    end
  end
end
