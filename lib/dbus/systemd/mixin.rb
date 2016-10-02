module DBus
  module Systemd
    module Mixin
      module MethodMissing
        attr_reader :object

        def method_missing(name, *args, &blk)
          if @object.respond_to?(name)
            @object.send(name, *args, &blk)
          else
            super
          end
        end

        def respond_to_missing?(*args)
          @object.respond_to?(*args) || super
        end
      end
    end
  end
end
