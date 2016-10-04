require 'spec_helper'

describe DBus::Systemd do
  it 'has a version number' do
    expect(DBus::Systemd::VERSION).not_to be nil
  end

  it 'sets the appropriate interface' do
    expect(DBus::Systemd::INTERFACE).to eq 'org.freedesktop.systemd1'
  end
end
