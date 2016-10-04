require 'spec_helper'

describe DBus::Systemd::Machined::Manager do
  it 'sets the right dbus node path' do
    expect(DBus::Systemd::Machined::Manager::NODE).to eq '/org/freedesktop/machine1'
  end

  it 'sets the right interface' do
    expect(DBus::Systemd::Machined::Manager::INTERFACE).to eq 'org.freedesktop.machine1.Manager'
  end
end
