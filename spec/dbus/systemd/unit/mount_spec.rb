require 'spec_helper'

describe DBus::Systemd::Unit::Mount do
  it 'sets the right interface' do
    expect(DBus::Systemd::Unit::Mount::INTERFACE).to eq 'org.freedesktop.systemd1.Mount'
  end
end
