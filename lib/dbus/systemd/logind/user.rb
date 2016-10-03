require_relative '../mixin'
require_relative 'manager'

module DBus
  module Systemd
    module Logind
      class User
        INTERFACE = 'org.freedesktop.login1.User'

        include Systemd::Mixin::MethodMissing
        include Systemd::Mixin::Properties

        def initialize(id, manager = Manager.new)
          user_path = manager.GetUser(id).first
          @object = manager.service.object(user_path)
                                   .tap(&:introspect)
        end
      end
    end
  end
end
