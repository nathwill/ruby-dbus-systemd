require_relative '../mixin'
require_relative 'manager'

module DBus
  module Systemd
    module Machined
      class Image
        INTERFACE = 'org.freedesktop.machine1.Image'

        include Systemd::Mixin::MethodMissing

        def initialize(name, manager = Manager.new)
          image_path = manager.GetImage(name).first
          @object = manager.service.object(image_path)
                                   .tap(&:introspect)
        end
      end
    end
  end
end
