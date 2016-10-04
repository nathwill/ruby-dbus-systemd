require 'spec_helper'

describe DBus::Systemd::Networkd::Manager do
  it 'sets the right dbus node path' do
    expect(DBus::Systemd::Networkd::Manager::NODE).to eq '/org/freedesktop/network1'
  end

  it 'sets the right interface' do
    expect(DBus::Systemd::Networkd::Manager::INTERFACE).to eq 'org.freedesktop.network1.Manager'
  end
end
