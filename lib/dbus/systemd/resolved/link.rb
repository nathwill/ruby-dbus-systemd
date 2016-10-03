require_relative '../mixin'
require_relative 'manager'

module DBus
  module Systemd
    module Resolved
      class Link
        INTERFACE = 'org.freedesktop.resolve1.Link'

        include Systemd::Mixin::MethodMissing

        def initialize(id, manager = Manager.new)
          link_path = manager.GetLink(id).first
          @object = manager.service.object(link_path)
                                   .tap(&:introspect)
        end
      end
    end
  end
end
