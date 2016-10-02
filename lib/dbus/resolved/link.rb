require_relative '../systemd/mixin'
require_relative 'manager'

module DBus
  module Resolved
    class Link
      INTERFACE = 'org.freedesktop.resolve1.Link'

      include DBus::Systemd::Mixin::MethodMissing

      def initialize(id, manager = Manager.new)
        link_path = manager.GetLink(id).first
        @object = manager.service.object(link_path)
                                 .tap(&:introspect)
      end
    end
  end
end
