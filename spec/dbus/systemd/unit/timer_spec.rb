require 'spec_helper'

describe DBus::Systemd::Unit::Timer do
  it 'sets the right interface' do
    expect(DBus::Systemd::Unit::Timer::INTERFACE).to eq 'org.freedesktop.systemd1.Timer'
  end
end
