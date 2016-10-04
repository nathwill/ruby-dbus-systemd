require 'spec_helper'

describe DBus::Systemd::Unit::Socket do
  it 'sets the right interface' do
    expect(DBus::Systemd::Unit::Socket::INTERFACE).to eq 'org.freedesktop.systemd1.Socket'
  end
end
