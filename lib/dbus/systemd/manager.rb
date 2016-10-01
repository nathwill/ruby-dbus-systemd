module DBus
  module Systemd
    class Manager
      OBJECT = '/org/freedesktop/systemd1'
      INTERFACE = 'org.freedesktop.systemd1.Manager'

      def initialize(bus = DBus::Systemd.system_bus)
        @object = bus.object(OBJECT)
                     .tap(&:introspect)
      end

      def get_unit(unit_name)
        DBus::Systemd::Unit.new(unit_name)
      end

      def get_unit_by_pid(pid)
        DBus::Systemd::Unit.new(@object.GetUnitByPID(pid).first)
      end

      def load_unit(unit_name)
        DBus::Systemd::Unit.new(@object.LoadUnit(unit_name).first)
      end

      def start_unit(unit_name, mode = 'replace')
        DBus::Systemd::Job.new(@object.StartUnit(unit_name, mode).first)
      end

      def start_unit_replace(old_unit, new_unit, mode = 'replace')
        DBus::Systemd::Job.new(@object.StartUnitReplace(old_unit, new_unit, mode).first)
      end

      def stop_unit(unit_name, mode = 'replace')
        DBus::Systemd::Job.new(@object.StopUnit(unit_name, mode).first)
      end

      def reload_unit(unit_name, mode = 'replace')
        DBus::Systemd::Job.new(@object.ReloadUnit(unit_name, mode).first)
      end

      def restart_unit(unit_name, mode = 'replace')
        DBus::Systemd::Job.new(@object.RestartUnit(unit_name, mode).first)
      end

      def try_restart_unit(unit_name, mode = 'replace')
        DBus::Systemd::Job.new(@object.TryRestartUnit(unit_name, mode).first)
      end

      def reload_or_restart_unit(unit_name, mode = 'replace')
        DBus::Systemd::Job.new(@object.ReloadOrRestartUnit(unit_name, mode).first)
      end

      def reload_or_try_restart_unit(unit_name, mode = 'replace')
        DBus::Systemd::Job.new(@object.ReloadOrTryRestartUnit(unit_name, mode).first)
      end

      def kill_unit(unit_name, who, signal)
        @object.KillUnit(unit_name, who, signal)
      end

      def reset_failed_unit(unit_name)
        @object.ResetFailedUnit(unit_name)
      end

      def get_job(job_id)
        DBus::Systemd::Job.new(@object.GetJob(job_id).first)
      end

      def cancel_job(job_id)
        @object.CancelJob(job_id)
      end

      def clear_jobs
        @object.ClearJobs
      end

      def reset_failed
        @object.ResetFailed
      end

      def list_units
        @object.ListUnits.first.each do |unit|
          # TODO
        end
      end

      def list_jobs
        @object.ListJobs.first
      end

      def subscribe
        @object.Subscribe
      end

      def unsubscribe
        @object.Unsubscribe
      end

      def create_snapshot(name, cleanup)
        DBus::Systemd::Unit.new(@object.CreateSnapshot(name, cleanup))
      end

      def remove_snapshot(name)
        @object.RemoveSnapshot(name)
      end

      def reload
        @object.Reload
      end

      def reexecute
        @object.Reexecute
      end

      def exit
        @object.Exit
      end

      def reboot
        @object.Reboot
      end

      def power_off
        @object.PowerOff
      end

      def halt
        @object.Halt
      end

      def k_exec
        @object.KExec
      end

      def switch_root(new_root, init)
        @object.SwitchRoot(new_root, init)
      end

      def set_environment(names)
        @object.SetEnvironment(names)
      end

      def unset_environment(names)
        @object.UnsetEnvironment(names)
      end

      def unset_and_set_environment(unset, set)
        @object.UnsetAndSetEnvironment(unset, set)
      end

      def list_unit_files
        @object.ListUnitFiles.first
      end

      def get_unit_file_state(file)
        @object.GetUnitFileState(file).first
      end

      def enable_unit_files(files, runtime, force)
        @object.EnableUnitFiles(files, runtime, force).first
      end

      def disable_unit_files(files, runtime)
        @object.DisableUnitFiles(files, runtime).first
      end

      def reenable_unit_files(files, runtime, force)
        @object.ReenableUnitFiles(files, runtime, force).first
      end

      def link_unit_files(files, runtime, force)
        @object.LinkUnitFiles(files, runtime, force).first
      end

      def preset_unit_files(files, runtime, force)
        @object.PresetUnitFiles(files, runtime, force).first
      end

      def mask_unit_files(files, runtime, force)
        @object.MaskUnitFiles(files, runtime, force).first
      end

      def unmask_unit_files(files, runtime, force)
        @object.UnmaskUnitFiles(files, runtime, force).first
      end

      def set_default_target(files)
        @object.SetDefaultTarget(files).first
      end

      def get_default_target
        @object.GetDefaultTarget.first
      end

      def set_unit_properties(name, runtime, properties)
        @object.SetUnitProperties(name, runtime, properties)
      end

      def start_transient_unit(name, mode, properties, aux)
        DBus::Systemd::Job.new(@object.StartTransientUnit(name, mode, properties, aux))
      end

      def properties

      end
    end
  end
end
