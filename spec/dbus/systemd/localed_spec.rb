require 'spec_helper'

describe DBus::Systemd::Localed do
  it 'sets the right dbus node path' do
    expect(DBus::Systemd::Localed::NODE).to eq '/org/freedesktop/locale1'
  end

  it 'sets the right interface' do
    expect(DBus::Systemd::Localed::INTERFACE).to eq 'org.freedesktop.locale1'
  end
end
