require 'spec_helper'

describe DBus::Systemd::Unit::Slice do
  it 'sets the right interface' do
    expect(DBus::Systemd::Unit::Slice::INTERFACE).to eq 'org.freedesktop.systemd1.Slice'
  end
end
