module DBus
  module Systemd
    class Job
      INTERFACE = 'org.freedesktop.systemd1.Job'

      def initialize(id, manager = DBus::Systemd::Manager.new)
        job_path = manager.object.GetJob(id).first
        @object = manager.service.object(job_path).tap(&:introspect)
      end
    end
  end
end
