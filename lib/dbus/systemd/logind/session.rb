require_relative '../mixin'
require_relative 'manager'

module DBus
  module Systemd
    module Logind
      class Session
        INTERFACE = 'org.freedesktop.login1.Session'

        include Systemd::Mixin::MethodMissing
        include Systemd::Mixin::Properties

        def initialize(id, manager = Manager.new)
          session_path = manager.GetSession(id).first
          @object = manager.service.object(session_path)
                                   .tap(&:introspect)
        end
      end
    end
  end
end
