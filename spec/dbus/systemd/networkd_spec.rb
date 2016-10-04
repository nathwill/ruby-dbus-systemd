require 'spec_helper'

describe DBus::Systemd::Networkd do
  it 'sets the right interface' do
    expect(DBus::Systemd::Networkd::INTERFACE).to eq 'org.freedesktop.network1'
  end
end
