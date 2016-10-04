require 'spec_helper'

describe DBus::Systemd::Manager do
  it 'sets the right dbus node path' do
    expect(DBus::Systemd::Manager::NODE).to eq '/org/freedesktop/systemd1'
  end

  it 'sets the right interface' do
    expect(DBus::Systemd::Manager::INTERFACE).to eq 'org.freedesktop.systemd1.Manager'
  end
end
