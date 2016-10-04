require 'spec_helper'

describe DBus::Systemd::Logind::Session do
  it 'sets the right interface' do
    expect(DBus::Systemd::Logind::Session::INTERFACE).to eq 'org.freedesktop.login1.Session'
  end
end
