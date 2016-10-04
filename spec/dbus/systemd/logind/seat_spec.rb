require 'spec_helper'

describe DBus::Systemd::Logind::Seat do
  it 'sets the right interface' do
    expect(DBus::Systemd::Logind::Seat::INTERFACE).to eq 'org.freedesktop.login1.Seat'
  end
end
