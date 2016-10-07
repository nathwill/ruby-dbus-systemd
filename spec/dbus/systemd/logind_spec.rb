require 'spec_helper'

describe DBus::Systemd::Logind do
  it 'sets the right service' do
    expect(DBus::Systemd::Logind::SERVICE).to eq 'org.freedesktop.login1'
  end
end
