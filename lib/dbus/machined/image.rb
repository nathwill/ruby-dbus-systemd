require_relative '../systemd/mixin'
require_relative 'manager'

module DBus
  module Machined
    class Image
      INTERFACE = 'org.freedesktop.machine1.Image'

      include DBus::Systemd::Mixin::MethodMissing

      def initialize(name, manager = Manager.new)
        image_path = manager.GetImage(name).first
        @object = manager.service.object(image_path)
                                 .tap(&:introspect)
      end
    end
  end
end
