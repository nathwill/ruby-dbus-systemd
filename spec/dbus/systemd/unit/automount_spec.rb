require 'spec_helper'

describe DBus::Systemd::Unit::Automount do
  it 'sets the right interface' do
    expect(DBus::Systemd::Unit::Automount::INTERFACE).to eq 'org.freedesktop.systemd1.Automount'
  end
end
