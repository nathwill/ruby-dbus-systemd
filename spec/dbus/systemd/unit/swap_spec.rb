require 'spec_helper'

describe DBus::Systemd::Unit::Swap do
  it 'sets the right interface' do
    expect(DBus::Systemd::Unit::Swap::INTERFACE).to eq 'org.freedesktop.systemd1.Swap'
  end
end
