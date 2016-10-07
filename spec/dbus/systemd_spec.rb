require 'spec_helper'

describe DBus::Systemd do
  it 'has a version number' do
    expect(DBus::Systemd::VERSION).not_to be nil
  end

  it 'sets the appropriate service' do
    expect(DBus::Systemd::SERVICE).to eq 'org.freedesktop.systemd1'
  end
end
