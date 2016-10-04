require 'spec_helper'

describe DBus::Systemd::Unit::Snapshot do
  it 'sets the right interface' do
    expect(DBus::Systemd::Unit::Snapshot::INTERFACE).to eq 'org.freedesktop.systemd1.Snapshot'
  end
end
