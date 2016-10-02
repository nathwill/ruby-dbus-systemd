require_relative 'method_missing'
require_relative 'manager'

module DBus
  module Systemd
    class Job
      INTERFACE = 'org.freedesktop.systemd1.Job'

      include MethodMissing

      def initialize(id, manager = Manager.new)
        job_path = manager.object.GetJob(id).first
        @object = manager.service.object(job_path)
                                 .tap(&:introspect)
      end
    end
  end
end
