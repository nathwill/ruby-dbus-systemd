require 'spec_helper'

describe DBus::Systemd::Unit::Service do
  it 'sets the right interface' do
    expect(DBus::Systemd::Unit::Service::INTERFACE).to eq 'org.freedesktop.systemd1.Service'
  end
end
