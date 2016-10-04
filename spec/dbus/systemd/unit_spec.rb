require 'spec_helper'

describe DBus::Systemd::Unit do
  it 'sets the right interface' do
    expect(DBus::Systemd::Unit::INTERFACE).to eq 'org.freedesktop.systemd1.Unit'
  end
end
