require_relative 'systemd/helpers'
require_relative 'systemd/mixin'

module DBus
  class Timedated
    NODE = '/org/freedesktop/timedate1'
    INTERFACE = 'org.freedesktop.timedate1'

    include Systemd::Mixin::MethodMissing

    attr_reader :service

    def initialize(bus = Systemd::Helpers.system_bus)
      @service = bus.service(INTERFACE)
      @object = @service.object(NODE)
                        .tap(&:introspect)
    end
  end
end
