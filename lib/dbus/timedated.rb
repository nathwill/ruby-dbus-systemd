require_relative 'systemd/method_missing'
require_relative 'systemd/bus'

module DBus
  class Timedated
    NODE = '/org/freedesktop/timedate1'
    INTERFACE = 'org.freedesktop.timedate1'

    include Systemd::MethodMissing

    attr_reader :service

    def initialize(bus = Systemd::Bus.system_bus)
      @service = bus.service(INTERFACE)
      @object = @service.object(NODE)
                        .tap(&:introspect)
    end
  end
end
