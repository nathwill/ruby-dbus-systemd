require 'spec_helper'

describe DBus::Systemd::Logind do
  it 'sets the right interface' do
    expect(DBus::Systemd::Logind::INTERFACE).to eq 'org.freedesktop.login1'
  end
end
