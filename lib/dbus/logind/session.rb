require_relative '../systemd/mixin'
require_relative 'manager'

module DBus
  module Logind
    class Session
      INTERFACE = 'org.freedesktop.login1.Session'

      include DBus::Systemd::Mixin::MethodMissing

      def initialize(id, manager = Manager.new)
        session_path = manager.GetSession(id).first
        @object = manager.service.object(session_path)
                                 .tap(&:introspect)
      end
    end
  end
end
