module DBus
  module Systemd
    module MethodMissing
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
