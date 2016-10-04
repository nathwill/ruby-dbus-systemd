require 'spec_helper'

describe DBus::Systemd::Logind::User do
  it 'sets the right interface' do
    expect(DBus::Systemd::Logind::User::INTERFACE).to eq 'org.freedesktop.login1.User'
  end
end
