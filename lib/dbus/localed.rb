require_relative 'systemd/helpers'
require_relative 'systemd/mixin'

module DBus
  class Localed
    NODE = '/org/freedesktop/locale1'
    INTERFACE = 'org.freedesktop.locale1'

    include Systemd::Mixin::MethodMissing

    attr_reader :service

    def initialize(bus = Systemd::Helpers.system_bus)
      @service = bus.service(INTERFACE)
      @object = @service.object(NODE)
                        .tap(&:introspect)
    end
  end
end
