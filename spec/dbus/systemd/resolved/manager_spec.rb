require 'spec_helper'

describe DBus::Systemd::Resolved::Manager do
  it 'sets the right dbus node path' do
    expect(DBus::Systemd::Resolved::Manager::NODE).to eq '/org/freedesktop/resolve1'
  end

  it 'sets the right interface' do
    expect(DBus::Systemd::Resolved::Manager::INTERFACE).to eq 'org.freedesktop.resolve1.Manager'
  end
end
