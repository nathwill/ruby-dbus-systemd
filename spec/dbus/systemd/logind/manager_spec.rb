require 'spec_helper'

describe DBus::Systemd::Logind::Manager do
  it 'sets the right dbus node path' do
    expect(DBus::Systemd::Logind::Manager::NODE).to eq '/org/freedesktop/login1'
  end

  it 'sets the right interface' do
    expect(DBus::Systemd::Logind::Manager::INTERFACE).to eq 'org.freedesktop.login1.Manager'
  end
end
