module DBus
  module Systemd
    class Job
      INTERFACE = 'org.freedesktop.systemd1.Job'

      def initialize(id, manager = DBus::Systemd::Manager.new)
        job_path = manager.object.GetJob(id).first
        @object = manager.service.object(job_path)
                                 .tap(&:introspect)
      end

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
