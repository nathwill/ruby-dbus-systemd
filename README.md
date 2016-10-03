# DBus::Systemd

Ruby library for simplifying access to systemd dbus interfaces.

Recommended Reading

  - [introduction to d-bus concepts section of sd-bus announcement blog post](http://0pointer.net/blog/the-new-sd-bus-api-of-systemd.html)
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

### DBus::Systemd::Hostnamed

For full docs, see [official docs](https://www.freedesktop.org/wiki/Software/systemd/hostnamed/).

```ruby
irb(main):001:0> h = DBus::Systemd::Hostnamed.new
=> ...
irb(main):002:0> h.object.methods - Object.methods
=> [:Set, :Get, :GetAll, :Ping, :GetMachineId, :Introspect, :SetHostname, :SetStaticHostname, :SetPrettyHostname, :SetIconName, :SetChassis, :SetDeployment, :SetLocation, :[], :[]=, :path, :destination, :bus, :introspect, :api, :subnodes, :introspected, :default_iface, :interfaces, :define_shortcut_methods, :has_iface?, :on_signal, :subnodes=, :introspected=, :default_iface=]
irb(main):004:0> h.Get(DBus::Systemd::Hostnamed::INTERFACE, 'Hostname').first
=> "derp.localdomain"
irb(main):005:0> h.SetHostname('my-hostname.localdomain', false)
=> []
irb(main):006:0> h.Get(DBus::Systemd::Hostnamed::INTERFACE, 'Hostname').first
=> "my-hostname.localdomain"
```

### DBus::Systemd::Importd

For full docs, see [official docs](https://www.freedesktop.org/wiki/Software/systemd/importd/).

```ruby
irb(main):007:0> im = DBus::Systemd::Importd::Manager.new
=> ...
irb(main):008:0> im.object.methods - Object.methods
=> [:Set, :Get, :GetAll, :ListTransfers, :Ping, :GetMachineId, :Introspect, :ImportTar, :ImportRaw, :ExportTar, :ExportRaw, :PullTar, :PullRaw, :CancelTransfer, :[], :[]=, :path, :destination, :bus, :introspect, :api, :subnodes, :introspected, :default_iface, :interfaces, :define_shortcut_methods, :has_iface?, :on_signal, :subnodes=, :introspected=, :default_iface=]
irb(main):008:0> im.PullRaw('https://dl.fedoraproject.org/pub/fedora/linux/releases/24/CloudImages/x86_64/images/Fedora-Cloud-Base-24-1.2.x86_64.raw.xz', 'Fedora-24', 'no', false)
=> [1, "/org/freedesktop/import1/transfer/_1"]
> im.transfers
=> [{:id=>1, :operation=>"pull-raw", :remote_file=>"https://dl.fedoraproject.org/pub/fedora/linux/releases/24/CloudImages/x86_64/images/Fedora-Cloud-Base-24-1.2.x86_64.raw.xz", :machine_name=>"Fedora-24", :progress=>0.0, :object_path=>"/org/freedesktop/import1/transfer/_1"}]
```

### DBus::Systemd::Localed

For full docs, see [official docs](https://www.freedesktop.org/wiki/Software/systemd/localed/).

```ruby
irb(main):009:0> l = DBus::Systemd::Localed.new
=> ...
irb(main):010:0> l.object.methods - Object.methods
=> [:Set, :Get, :GetAll, :Ping, :GetMachineId, :Introspect, :SetLocale, :SetVConsoleKeyboard, :SetX11Keyboard, :[], :[]=, :path, :destination, :bus, :introspect, :api, :subnodes, :introspected, :default_iface, :interfaces, :define_shortcut_methods, :has_iface?, :on_signal, :subnodes=, :introspected=, :default_iface=]
irb(main):011:0> l.GetAll(DBus::Systemd::Localed::INTERFACE).first
=> {"Locale"=>["LANG=en_US.UTF-8"], "X11Layout"=>"", "X11Model"=>"", "X11Variant"=>"", "X11Options"=>"", "VConsoleKeymap"=>"us", "VConsoleKeymapToggle"=>""}
```

### DBus::Systemd::Logind

For full docs, see [official docs](https://www.freedesktop.org/wiki/Software/systemd/logind/).

```ruby
irb(main):012:0> l = DBus::Systemd::Logind::Manager.new
=> ...
irb(main):013:0> l.object.methods - Object.methods
=> [:Set, :Get, :GetAll, :ListSeats, :ListSessions, :ListUsers, :GetSession, :GetUser, :GetSeat, :Ping, :GetMachineId, :Introspect, :GetSessionByPID, :GetUserByPID, :ListInhibitors, :CreateSession, :ReleaseSession, :ActivateSession, :ActivateSessionOnSeat, :LockSession, :UnlockSession, :LockSessions, :UnlockSessions, :KillSession, :KillUser, :TerminateSession, :TerminateUser, :TerminateSeat, :SetUserLinger, :AttachDevice, :FlushDevices, :PowerOff, :Reboot, :Suspend, :Hibernate, :HybridSleep, :CanPowerOff, :CanReboot, :CanSuspend, :CanHibernate, :CanHybridSleep, :ScheduleShutdown, :CancelScheduledShutdown, :Inhibit, :CanRebootToFirmwareSetup, :SetRebootToFirmwareSetup, :SetWallMessage, :[], :[]=, :path, :destination, :bus, :introspect, :api, :subnodes, :introspected, :default_iface, :interfaces, :define_shortcut_methods, :has_iface?, :on_signal, :subnodes=, :introspected=, :default_iface=]
irb(main):014:0> l.users
=> [{:id=>1000, :name=>"vagrant", :object_path=>"/org/freedesktop/login1/user/_1000"}]
irb(main):015:0> l.seats
=> [{:id=>"seat0", :object_path=>"/org/freedesktop/login1/seat/seat0"}]
irb(main):016:0> l.sessions
=> [{:id=>"3", :user_id=>1000, :user_name=>"vagrant", :seat_id=>"", :object_path=>"/org/freedesktop/login1/session/_33"}]
irb(main):017:0> u = l.user(1000)
=> ...
irb(main):019:0> u.GetAll(DBus::Systemd::Logind::User::INTERFACE).first
=> {"UID"=>1000, "GID"=>1000, "Name"=>"vagrant", "Timestamp"=>1475452037907590, "TimestampMonotonic"=>122159600, "RuntimePath"=>"/run/user/1000", "Service"=>"user@1000.service", "Slice"=>"user-1000.slice", "Display"=>["3", "/org/freedesktop/login1/session/_33"], "State"=>"active", "Sessions"=>[["3", "/org/freedesktop/login1/session/_33"]], "IdleHint"=>false, "IdleSinceHint"=>0, "IdleSinceHintMonotonic"=>0, "Linger"=>false}
```

### DBus::Systemd::Machined

For full docs, see [official docs](https://www.freedesktop.org/wiki/Software/systemd/machined/).

```ruby
irb(main):021:0> mm = DBus::Systemd::Machined::Manager.new
=> ...
irb(main):022:0> mm.object.methods - Object.methods
=> [:Set, :Get, :GetAll, :ListMachines, :ListImages, :GetMachine, :GetImage, :Ping, :GetMachineId, :Introspect, :GetMachineByPID, :CreateMachine, :CreateMachineWithNetwork, :RegisterMachine, :RegisterMachineWithNetwork, :TerminateMachine, :KillMachine, :GetMachineAddresses, :GetMachineOSRelease, :OpenMachinePTY, :OpenMachineLogin, :OpenMachineShell, :BindMountMachine, :CopyFromMachine, :CopyToMachine, :RemoveImage, :RenameImage, :CloneImage, :MarkImageReadOnly, :SetPoolLimit, :SetImageLimit, :MapFromMachineUser, :MapToMachineUser, :MapFromMachineGroup, :MapToMachineGroup, :[], :[]=, :path, :destination, :bus, :introspect, :api, :subnodes, :introspected, :default_iface, :interfaces, :define_shortcut_methods, :has_iface?, :on_signal, :subnodes=, :introspected=, :default_iface=]
irb(main):024:0> mm.machines
=> [{:name=>".host", :class=>"host", :service_id=>"", :object_path=>"/org/freedesktop/machine1/machine/_2ehost"}]
irb(main):023:0> mm.images
=> [{:name=>"Fedora-23", :type=>"raw", :read_only=>false, :creation_time=>1446171608000000, :modification_time=>1446171608000000, :disk_space=>589676544, :object_path=>"/org/freedesktop/machine1/image/Fedora_2d23"}, {:name=>".raw-https:\\x2f\\x2fdl\\x2efedoraproject\\x2eorg\\x2fpub\\x2ffedora\\x2flinux\\x2freleases\\x2f24\\x2fCloudImages\\x2fx86_64\\x2fimages\\x2fFedora-Cloud-Base-24-1\\x2e2\\x2ex86_64\\x2eraw\\x2exz.\\x227fef0a4-5353f9c7441a0\\x22", :type=>"raw", :read_only=>true, :creation_time=>1465922207000000, :modification_time=>1465922207000000, :disk_space=>540872704, :object_path=>"/org/freedesktop/machine1/image/_2eraw_2dhttps_3a_5cx2f_5cx2fdl_5cx2efedoraproject_5cx2eorg_5cx2fpub_5cx2ffedora_5cx2flinux_5cx2freleases_5cx2f24_5cx2fCloudImages_5cx2fx86_5f64_5cx2fimages_5cx2fFedora_2dCloud_2dBase_2d24_2d1_5cx2e2_5cx2ex86_5f64_5cx2eraw_5cx2exz_2e_5cx227fef0a4_2d5353f9c7441a0_5cx22"}, {:name=>".raw-https:\\x2f\\x2fdl\\x2efedoraproject\\x2eorg\\x2fpub\\x2ffedora\\x2flinux\\x2freleases\\x2f23\\x2fCloud\\x2fx86_64\\x2fImages\\x2fFedora-Cloud-Base-23-20151030\\x2ex86_64\\x2eraw\\x2exz.\\x229205894-5234910faa600\\x22", :type=>"raw", :read_only=>true, :creation_time=>1446171608000000, :modification_time=>1446171608000000, :disk_space=>589676544, :object_path=>"/org/freedesktop/machine1/image/_2eraw_2dhttps_3a_5cx2f_5cx2fdl_5cx2efedoraproject_5cx2eorg_5cx2fpub_5cx2ffedora_5cx2flinux_5cx2freleases_5cx2f23_5cx2fCloud_5cx2fx86_5f64_5cx2fImages_5cx2fFedora_2dCloud_2dBase_2d23_2d20151030_5cx2ex86_5f64_5cx2eraw_5cx2exz_2e_5cx229205894_2d5234910faa600_5cx22"}, {:name=>"Fedora-24", :type=>"raw", :read_only=>false, :creation_time=>1465922207000000, :modification_time=>1465922207000000, :disk_space=>540872704, :object_path=>"/org/freedesktop/machine1/image/Fedora_2d24"}, {:name=>"test", :type=>"raw", :read_only=>false, :creation_time=>1446171608000000, :modification_time=>1446171608000000, :disk_space=>589676544, :object_path=>"/org/freedesktop/machine1/image/test"}, {:name=>".host", :type=>"directory", :read_only=>false, :creation_time=>0, :modification_time=>0, :disk_space=>18446744073709551615, :object_path=>"/org/freedesktop/machine1/image/_2ehost"}]
irb(main):025:0> mm.GetAll(DBus::Systemd::Machined::Manager::INTERFACE).first
=> {"PoolPath"=>"/var/lib/machines", "PoolUsage"=>1191448576, "PoolLimit"=>2105020416}
irb(main):026:0> mi = mm.image('Fedora-24')
=> ...
irb(main):027:0> mi.object.methods - Object.methods
=> [:Set, :Get, :GetAll, :Ping, :GetMachineId, :Introspect, :Remove, :Rename, :Clone, :MarkReadOnly, :SetLimit, :[], :[]=, :path, :destination, :bus, :introspect, :api, :subnodes, :introspected, :default_iface, :interfaces, :define_shortcut_methods, :has_iface?, :on_signal, :subnodes=, :introspected=, :default_iface=]
irb(main):028:0> mi.GetAll(DBus::Systemd::Machined::Image::INTERFACE).first
=> {"Name"=>"Fedora-24", "Path"=>"/var/lib/machines/Fedora-24.raw", "Type"=>"raw", "ReadOnly"=>false, "CreationTimestamp"=>1465922207000000, "ModificationTimestamp"=>1465922207000000, "Usage"=>540872704, "Limit"=>3221225472, "UsageExclusive"=>540872704, "LimitExclusive"=>3221225472}
irb(main):029:0> machine = mm.machine('.host')
=> ..
irb(main):030:0> machine.object.methods - Object.methods
=> [:Set, :Get, :GetAll, :Kill, :Ping, :GetMachineId, :Introspect, :Terminate, :GetAddresses, :GetOSRelease, :OpenPTY, :OpenLogin, :OpenShell, :BindMount, :CopyFrom, :CopyTo, :[], :[]=, :path, :destination, :bus, :introspect, :api, :subnodes, :introspected, :default_iface, :interfaces, :define_shortcut_methods, :has_iface?, :on_signal, :subnodes=, :introspected=, :default_iface=]
irb(main):032:0> machine.GetAll(DBus::Systemd::Machined::Machine::INTERFACE).first
=> {"Name"=>".host", "Id"=>[77, 46, 68, 242, 105, 232, 78, 52, 157, 152, 76, 171, 175, 145, 140, 130], "Timestamp"=>1475451915747985, "TimestampMonotonic"=>0, "Service"=>"", "Unit"=>"-.slice", "Leader"=>1, "Class"=>"host", "RootDirectory"=>"/", "NetworkInterfaces"=>[], "State"=>"running"}
```

### DBus::Systemd::Resolved

For full docs, see [official docs](https://www.freedesktop.org/wiki/Software/systemd/resolved/).

```ruby
irb(main):030:0> rm = DBus::Systemd::Resolved::Manager.new
=> ...
irb(main):030:0> rm.object.methods - Object.methods
=> [:Set, :Get, :GetAll, :Ping, :GetMachineId, :Introspect, :GetLink, :ResolveHostname, :ResolveAddress, :ResolveRecord, :ResolveService, :ResetStatistics, :SetLinkDNS, :SetLinkDomains, :SetLinkLLMNR, :SetLinkMulticastDNS, :SetLinkDNSSEC, :SetLinkDNSSECNegativeTrustAnchors, :RevertLink, :[], :[]=, :path, :destination, :bus, :introspect, :api, :subnodes, :introspected, :default_iface, :interfaces, :define_shortcut_methods, :has_iface?, :on_signal, :subnodes=, :introspected=, :default_iface=]
irb(main):030:0> rm.Get(DBus::Resolved::Manager::INTERFACE, 'DNSSECSupported').first
=> false
```

### DBus::Systemd::Timedated

For full docs, see [official docs](https://www.freedesktop.org/wiki/Software/systemd/timedated/).

```ruby
irb(main):030:0>  t = DBus::Systemd::Timedated.new
=> ...
irb(main):030:0> t.object.methods - Object.methods
=> [:Set, :Get, :GetAll, :Ping, :GetMachineId, :Introspect, :SetTime, :SetTimezone, :SetLocalRTC, :SetNTP, :[], :[]=, :path, :destination, :bus, :introspect, :api, :subnodes, :introspected, :default_iface, :interfaces, :define_shortcut_methods, :has_iface?, :on_signal, :subnodes=, :introspected=, :default_iface=]
irb(main):030:0> t.GetAll(DBus::Systemd::Timedated::INTERFACE).first
=> {"Timezone"=>"UTC", "LocalRTC"=>true, "CanNTP"=>true, "NTP"=>false, "NTPSynchronized"=>true, "TimeUSec"=>1475454744352557, "RTCTimeUSec"=>1475454742000000}
irb(main):030:0> t.SetTimezone('America/Los_Angeles', false)
=> []
irb(main):030:0> t.Get(DBus::Systemd::Timedated::INTERFACE, 'Timezone').first
=> "America/Los_Angeles"
```

### DBus::Systemd::Manager

For full docs, see [official docs](https://www.freedesktop.org/wiki/Software/systemd/dbus/).

```ruby
irb(main):030:0> mgr = DBus::Systemd::Manager.new
=> ...
irb(main):030:0> mgr.object.methods - Object.methods
=> [:Set, :Get, :ListUnits, :GetAll, :GetUnit, :GetJob, :Ping, :GetMachineId, :Introspect, :GetUnitByPID, :LoadUnit, :StartUnit, :StartUnitReplace, :StopUnit, :ReloadUnit, :RestartUnit, :TryRestartUnit, :ReloadOrRestartUnit, :ReloadOrTryRestartUnit, :KillUnit, :ResetFailedUnit, :SetUnitProperties, :StartTransientUnit, :CancelJob, :ClearJobs, :ResetFailed, :ListUnitsFiltered, :ListJobs, :Subscribe, :Unsubscribe, :Dump, :CreateSnapshot, :RemoveSnapshot, :Reload, :Reexecute, :Exit, :Reboot, :PowerOff, :Halt, :KExec, :SwitchRoot, :SetEnvironment, :UnsetEnvironment, :UnsetAndSetEnvironment, :ListUnitFiles, :GetUnitFileState, :EnableUnitFiles, :DisableUnitFiles, :ReenableUnitFiles, :LinkUnitFiles, :PresetUnitFiles, :PresetUnitFilesWithMode, :MaskUnitFiles, :UnmaskUnitFiles, :SetDefaultTarget, :GetDefaultTarget, :PresetAllUnitFiles, :AddDependencyUnitFiles, :SetExitCode, :[], :[]=, :path, :destination, :bus, :introspect, :api, :subnodes, :introspected, :default_iface, :interfaces, :define_shortcut_methods, :has_iface?, :on_signal, :subnodes=, :introspected=, :default_iface=] 
irb(main):030:0> mgr.GetDefaultTarget.first
=> "multi-user.target"
irb(main):036:0> mgr.Get(DBus::Systemd::Manager::INTERFACE, 'Version').first
=> "229"
irb(main):037:0> mgr.Get(DBus::Systemd::Manager::INTERFACE, 'UnitPath').first
=> ["/etc/systemd/system", "/run/systemd/system", "/run/systemd/generator", "/usr/local/lib/systemd/system", "/usr/lib/systemd/system", "/run/systemd/generator.late"]
irb(main):038:0> mgr.Get(DBus::Systemd::Manager::INTERFACE, 'NFailedUnits').first
=> 0
```

### DBus::Systemd::Unit

For full docs, see [official docs](https://www.freedesktop.org/wiki/Software/systemd/dbus/).

```ruby
irb(main):005:0> sshd = DBus::Systemd::Unit.new('sshd.service')
=> ...
irb(main):006:0> sshd.object.methods - Object.methods
=> [:Set, :Get, :GetAll, :Kill, :Ping, :GetMachineId, :Introspect, :ResetFailed, :Reload, :Start, :Stop, :Restart, :TryRestart, :ReloadOrRestart, :ReloadOrTryRestart, :SetProperties, :[], :[]=, :path, :destination, :bus, :introspect, :api, :subnodes, :introspected, :default_iface, :interfaces, :define_shortcut_methods, :has_iface?, :on_signal, :subnodes=, :introspected=, :default_iface=]
irb(main):007:0> sshd.Get(DBus::Systemd::Unit::INTERFACE, 'Wants').first
=> ["sshd-keygen.target"]
irb(main):008:0> sshd.Get(DBus::Systemd::Unit::Service::INTERFACE, 'ExecStart').first
=> [["/usr/sbin/sshd", ["/usr/sbin/sshd", "$OPTIONS"], false, 1475455155565079, 3239817089, 1475455155581392, 3239833403, 5860, 1, 0]]
irb(main):010:0> sshd.Restart('replace')
=> ["/org/freedesktop/systemd1/job/3326"]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

A Vagrantfile is provided in the VCS root that creates a Fedora vagrant box, with which library can be tested and D-Bus interfaces explored.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nathwill/ruby-dbus-systemd.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

