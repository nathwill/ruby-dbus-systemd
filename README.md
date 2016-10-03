# DBus::Systemd

Ruby library for simplifying access to systemd dbus interfaces.

Recommended Reading

  - [systemd D-Bus specification](https://www.freedesktop.org/wiki/Software/systemd/dbus/)
  - [D-Bus specification](https://dbus.freedesktop.org/doc/dbus-specification.html)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dbus-systemd'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dbus-systemd

## Usage

### DBus::Hostnamed

```ruby
> require 'dbus/hostnamed'
=> true
> h = DBus::Hostnamed.new
...
> h.object.methods - Object.methods
=> [:Set, :Get, :GetAll, :Ping, :GetMachineId, :Introspect, :SetHostname, :SetStaticHostname, :SetPrettyHostname, :SetIconName, :SetChassis, :SetDeployment, :SetLocation, :[], :[]=, :path, :destination, :bus, :introspect, :api, :subnodes, :introspected, :default_iface, :interfaces, :define_shortcut_methods, :has_iface?, :on_signal, :subnodes=, :introspected=, :default_iface=]
> h.GetMachineId.first
=> "4d2e44f269e84e349d984cabaf918c82"
> h.SetHostname('derp.localdomain', false)
=> []
> h.Get(DBus::Hostnamed::INTERFACE, 'Hostname').first
=> "derp.localdomain"
```

### DBus::Systemd::Importd::Manager

```ruby
> require 'dbus/importd/manager'
=> true
> m = DBus::Importd::Manager.new
...
> m.object.methods - Object.methods
=> [:Set, :Get, :GetAll, :Ping, :GetMachineId, :Introspect, :ListTransfers, :ImportTar, :ImportRaw, :ExportTar, :ExportRaw, :PullTar, :PullRaw, :CancelTransfer, :[], :[]=, :path, :destination, :bus, :introspect, :api, :subnodes, :introspected, :default_iface, :interfaces, :define_shortcut_methods, :has_iface?, :on_signal, :subnodes=, :introspected=, :default_iface=]
> m.PullRaw('https://dl.fedoraproject.org/pub/fedora/linux/releases/24/CloudImages/x86_64/images/Fedora-Cloud-Base-24-1.2.x86_64.raw.xz', 'Fedora-24', 'no', false)
=> [1, "/org/freedesktop/import1/transfer/_1"]
> m.transfers
=> [{:id=>1, :operation=>"pull-raw", :remote_file=>"https://dl.fedoraproject.org/pub/fedora/linux/releases/24/CloudImages/x86_64/images/Fedora-Cloud-Base-24-1.2.x86_64.raw.xz", :machine_name=>"Fedora-24", :progress=>0.0, :object_path=>"/org/freedesktop/import1/transfer/_1"}]
```

### DBus::Systemd::Machined

```ruby
> require 'dbus/machined/manager'
> m = DBus::Machined::Manager.new
...
> m.object.methods - Object.methods
=> [:Set, :Get, :GetAll, :Ping, :GetMachineId, :Introspect, :ListMachines, :ListImages, :GetMachine, :GetImage, :GetMachineByPID, :CreateMachine, :CreateMachineWithNetwork, :RegisterMachine, :RegisterMachineWithNetwork, :TerminateMachine, :KillMachine, :GetMachineAddresses, :GetMachineOSRelease, :OpenMachinePTY, :OpenMachineLogin, :OpenMachineShell, :BindMountMachine, :CopyFromMachine, :CopyToMachine, :RemoveImage, :RenameImage, :CloneImage, :MarkImageReadOnly, :SetPoolLimit, :SetImageLimit, :MapFromMachineUser, :MapToMachineUser, :MapFromMachineGroup, :MapToMachineGroup, :[], :[]=, :path, :destination, :bus, :introspect, :api, :subnodes, :introspected, :default_iface, :interfaces, :define_shortcut_methods, :has_iface?, :on_signal, :subnodes=, :introspected=, :default_iface=]
> m.Get(DBus::Machined::Manager::INTERFACE, 'PoolPath').first
=> "/var/lib/machines"
> m.machines
=> [{:name=>".host", :class=>"host", :service_id=>"", :object_path=>"/org/freedesktop/machine1/machine/_2ehost"}]
> m.CloneImage('Fedora-23', 'test', false)
=> []
> m.images
=> [{:name=>"Fedora-23", :type=>"raw", :read_only=>false, :creation_time=>1446171608000000, :modification_time=>1446171608000000, :disk_space=>589676544, :object_path=>"/org/freedesktop/machine1/image/Fedora_2d23"}, {:name=>".raw-https:\\x2f\\x2fdl\\x2efedoraproject\\x2eorg\\x2fpub\\x2ffedora\\x2flinux\\x2freleases\\x2f24\\x2fCloudImages\\x2fx86_64\\x2fimages\\x2fFedora-Cloud-Base-24-1\\x2e2\\x2ex86_64\\x2eraw\\x2exz.\\x227fef0a4-5353f9c7441a0\\x22", :type=>"raw", :read_only=>true, :creation_time=>1465922207000000, :modification_time=>1465922207000000, :disk_space=>540872704, :object_path=>"/org/freedesktop/machine1/image/_2eraw_2dhttps_3a_5cx2f_5cx2fdl_5cx2efedoraproject_5cx2eorg_5cx2fpub_5cx2ffedora_5cx2flinux_5cx2freleases_5cx2f24_5cx2fCloudImages_5cx2fx86_5f64_5cx2fimages_5cx2fFedora_2dCloud_2dBase_2d24_2d1_5cx2e2_5cx2ex86_5f64_5cx2eraw_5cx2exz_2e_5cx227fef0a4_2d5353f9c7441a0_5cx22"}, {:name=>".raw-https:\\x2f\\x2fdl\\x2efedoraproject\\x2eorg\\x2fpub\\x2ffedora\\x2flinux\\x2freleases\\x2f23\\x2fCloud\\x2fx86_64\\x2fImages\\x2fFedora-Cloud-Base-23-20151030\\x2ex86_64\\x2eraw\\x2exz.\\x229205894-5234910faa600\\x22", :type=>"raw", :read_only=>true, :creation_time=>1446171608000000, :modification_time=>1446171608000000, :disk_space=>589676544, :object_path=>"/org/freedesktop/machine1/image/_2eraw_2dhttps_3a_5cx2f_5cx2fdl_5cx2efedoraproject_5cx2eorg_5cx2fpub_5cx2ffedora_5cx2flinux_5cx2freleases_5cx2f23_5cx2fCloud_5cx2fx86_5f64_5cx2fImages_5cx2fFedora_2dCloud_2dBase_2d23_2d20151030_5cx2ex86_5f64_5cx2eraw_5cx2exz_2e_5cx229205894_2d5234910faa600_5cx22"}, {:name=>"Fedora-24", :type=>"raw", :read_only=>false, :creation_time=>1465922207000000, :modification_time=>1465922207000000, :disk_space=>540872704, :object_path=>"/org/freedesktop/machine1/image/Fedora_2d24"}, {:name=>"test", :type=>"raw", :read_only=>false, :creation_time=>1446171608000000, :modification_time=>1446171608000000, :disk_space=>589676544, :object_path=>"/org/freedesktop/machine1/image/test"}, {:name=>".host", :type=>"directory", :read_only=>false, :creation_time=>0, :modification_time=>0, :disk_space=>18446744073709551615, :object_path=>"/org/freedesktop/machine1/image/_2ehost"}]
```

### DBus::Logind::Manager

```ruby
> require 'dbus/logind/manager'
=> true
> m.object.methods - Object.methods
=> [:Set, :Get, :GetAll, :Ping, :GetMachineId, :Introspect, :Reboot, :PowerOff, :ListSeats, :ListSessions, :ListUsers, :GetSession, :GetUser, :GetSeat, :GetSessionByPID, :GetUserByPID, :ListInhibitors, :CreateSession, :ReleaseSession, :ActivateSession, :ActivateSessionOnSeat, :LockSession, :UnlockSession, :LockSessions, :UnlockSessions, :KillSession, :KillUser, :TerminateSession, :TerminateUser, :TerminateSeat, :SetUserLinger, :AttachDevice, :FlushDevices, :Suspend, :Hibernate, :HybridSleep, :CanPowerOff, :CanReboot, :CanSuspend, :CanHibernate, :CanHybridSleep, :ScheduleShutdown, :CancelScheduledShutdown, :Inhibit, :CanRebootToFirmwareSetup, :SetRebootToFirmwareSetup, :SetWallMessage, :[], :[]=, :path, :destination, :bus, :introspect, :api, :subnodes, :introspected, :default_iface, :interfaces, :define_shortcut_methods, :has_iface?, :on_signal, :subnodes=, :introspected=, :default_iface=]
> m.users
=> [{:id=>1000, :name=>"vagrant", :object_path=>"/org/freedesktop/login1/user/_1000"}]
> u = m.user(1000)
=> ...
```

### DBus::Resolved::Manager

```ruby
> require 'dbus/resolved/manager'
=> true
> m = DBus::Resolved::Manager.new
=> ...
> m.object.methods - Object.methods
=> [:Set, :Get, :GetAll, :Ping, :GetMachineId, :Introspect, :GetLink, :ResolveHostname, :ResolveAddress, :ResolveRecord, :ResolveService, :ResetStatistics, :SetLinkDNS, :SetLinkDomains, :SetLinkLLMNR, :SetLinkMulticastDNS, :SetLinkDNSSEC, :SetLinkDNSSECNegativeTrustAnchors, :RevertLink, :[], :[]=, :path, :destination, :bus, :introspect, :api, :subnodes, :introspected, :default_iface, :interfaces, :define_shortcut_methods, :has_iface?, :on_signal, :subnodes=, :introspected=, :default_iface=]
> m.Get(DBus::Resolved::Manager::INTERFACE, 'DNSSECSupported').first
=> false
```

### DBus::Timedated

```ruby
> require 'dbus/timedated'
=> true
> t = DBus::Timedated.new
=> ...
> t.object.methods - Object.methods
=> [:Set, :Get, :GetAll, :Ping, :GetMachineId, :Introspect, :SetTime, :SetTimezone, :SetLocalRTC, :SetNTP, :[], :[]=, :path, :destination, :bus, :introspect, :api, :subnodes, :introspected, :default_iface, :interfaces, :define_shortcut_methods, :has_iface?, :on_signal, :subnodes=, :introspected=, :default_iface=]
> t.GetAll(DBus::Timedated::INTERFACE).first
=> {"Timezone"=>"UTC", "LocalRTC"=>true, "CanNTP"=>true, "NTP"=>false, "NTPSynchronized"=>true, "TimeUSec"=>1475454744352557, "RTCTimeUSec"=>1475454742000000}
> t.SetTimezone('America/Los_Angeles', false)
=> []
> t.Get(DBus::Timedated::INTERFACE, 'Timezone').first
=> "America/Los_Angeles"
```

### DBus::Systemd::Manager

```ruby
require 'dbus/systemd/manager'

> mgr = DBus::Systemd::Manager.new
...
> mgr.object.methods - Object.methods
> mgr.object.methods - Object.methods
=> [:Set, :Get, :ListUnits, :GetAll, :GetUnit, :GetJob, :Ping, :GetMachineId, :Introspect, :GetUnitByPID, :LoadUnit, :StartUnit, :StartUnitReplace, :StopUnit, :ReloadUnit, :RestartUnit, :TryRestartUnit, :ReloadOrRestartUnit, :ReloadOrTryRestartUnit, :KillUnit, :ResetFailedUnit, :SetUnitProperties, :StartTransientUnit, :CancelJob, :ClearJobs, :ResetFailed, :ListUnitsFiltered, :ListJobs, :Subscribe, :Unsubscribe, :Dump, :CreateSnapshot, :RemoveSnapshot, :Reload, :Reexecute, :Exit, :Reboot, :PowerOff, :Halt, :KExec, :SwitchRoot, :SetEnvironment, :UnsetEnvironment, :UnsetAndSetEnvironment, :ListUnitFiles, :GetUnitFileState, :EnableUnitFiles, :DisableUnitFiles, :ReenableUnitFiles, :LinkUnitFiles, :PresetUnitFiles, :PresetUnitFilesWithMode, :MaskUnitFiles, :UnmaskUnitFiles, :SetDefaultTarget, :GetDefaultTarget, :PresetAllUnitFiles, :AddDependencyUnitFiles, :SetExitCode, :[], :[]=, :path, :destination, :bus, :introspect, :api, :subnodes, :introspected, :default_iface, :interfaces, :define_shortcut_methods, :has_iface?, :on_signal, :subnodes=, :introspected=, :default_iface=] 
> mgr.GetDefaultTarget.first
=> "multi-user.target"
```

### DBus::Systemd::Unit

```ruby
> require 'dbus/systemd/unit'
=> true
> u = DBus::Systemd::Unit.new('sshd.service')
=> ...
> u.object.methods - Object.methods
=> [:Set, :Get, :GetAll, :Kill, :Ping, :GetMachineId, :Introspect, :ResetFailed, :Reload, :Start, :Stop, :Restart, :TryRestart, :ReloadOrRestart, :ReloadOrTryRestart, :SetProperties, :[], :[]=, :path, :destination, :bus, :introspect, :api, :subnodes, :introspected, :default_iface, :interfaces, :define_shortcut_methods, :has_iface?, :on_signal, :subnodes=, :introspected=, :default_iface=]
> u.Get(DBus::Systemd::Unit::INTERFACE, 'WantedBy').first
=> ["multi-user.target"]
> u.Get(DBus::Systemd::Unit::Service::INTERFACE, 'ExecStart').first
=> [["/usr/sbin/sshd", ["/usr/sbin/sshd", "$OPTIONS"], false, 0, 0, 0, 0, 0, 0, 0]]
> u.Restart('replace')
=> ["/org/freedesktop/systemd1/job/1783"]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

A Vagrantfile is provided in the VCS root that creates a Fedora vagrant box, with which library can be tested and D-Bus interfaces explored.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nathwill/ruby-dbus-systemd.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

