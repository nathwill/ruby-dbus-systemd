# Dbus::Systemd

Ruby library for simplifying access to systemd dbus interfaces.

Recommanded Reading

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



## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

A Vagrantfile is provided in the VCS root that creates a Fedora vagrant box, with which library can be tested and D-Bus interfaces explored.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nathwill/ruby-dbus-systemd.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

