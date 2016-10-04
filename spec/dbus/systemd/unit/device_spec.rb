require 'spec_helper'

describe DBus::Systemd::Unit::Device do
  it 'sets the right interface' do
    expect(DBus::Systemd::Unit::Device::INTERFACE).to eq 'org.freedesktop.systemd1.Device'
  end
end
