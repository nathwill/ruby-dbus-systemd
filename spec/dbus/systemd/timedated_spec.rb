require 'spec_helper'

describe DBus::Systemd::Timedated do
  it 'sets the right dbus node path' do
    expect(DBus::Systemd::Timedated::NODE).to eq '/org/freedesktop/timedate1'
  end

  it 'sets the right service' do
    expect(DBus::Systemd::Timedated::SERVICE).to eq 'org.freedesktop.timedate1'
  end

  it 'sets the right interface' do
    expect(DBus::Systemd::Timedated::INTERFACE).to eq 'org.freedesktop.timedate1'
  end
end
