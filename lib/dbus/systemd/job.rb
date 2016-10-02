require_relative 'manager'
require_relative 'mixin'

module DBus
  module Systemd
    class Job
      INTERFACE = 'org.freedesktop.systemd1.Job'

      include Mixin::MethodMissing

      def initialize(id, manager = Manager.new)
        job_path = manager.GetJob(id).first
        @object = manager.service.object(job_path)
                                 .tap(&:introspect)
      end
    end
  end
end
