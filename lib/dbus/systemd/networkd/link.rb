require_relative '../mixin'
require_relative 'manager'

module DBus
  module Systemd
    module Networkd
      class Link
        INTERFACE = 'org.freedesktop.network1.Link'

        include Systemd::Mixin::MethodMissing
        include Systemd::Mixin::Properties

        def initialize(id, manager = Manager.new)
          @object = manager.service.object("#{Manager::NODE}/link/#{id}")
                                   .tap(&:introspect)
        end
      end
    end
  end
end
