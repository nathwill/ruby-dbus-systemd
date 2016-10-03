require_relative '../systemd/mixin'
require_relative 'manager'

module DBus
  module Logind
    class User
      INTERFACE = 'org.freedesktop.login1.User'

      include DBus::Systemd::Mixin::MethodMissing

      def initialize(id, manager = Manager.new)
        user_path = manager.GetUser(id).first
        @object = manager.service.object(user_path)
                                 .tap(&:introspect)
      end
    end
  end
end
