require_relative 'systemd/helpers'
require_relative 'systemd/mixin'

module DBus
  class Hostnamed
    NODE = '/org/freedesktop/hostname1'
    INTERFACE = 'org.freedesktop.hostname1'

    include Systemd::Mixin::MethodMissing

    attr_reader :service

    def initialize(bus = Systemd::Helpers.system_bus)
      @service = bus.service(INTERFACE)
      @object = @service.object(NODE)
                        .tap(&:introspect)
    end
  end
end
