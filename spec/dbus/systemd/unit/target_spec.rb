require 'spec_helper'

describe DBus::Systemd::Unit::Target do
  it 'sets the right interface' do
    expect(DBus::Systemd::Unit::Target::INTERFACE).to eq 'org.freedesktop.systemd1.Target'
  end
end
