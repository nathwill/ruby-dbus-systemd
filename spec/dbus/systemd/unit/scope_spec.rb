require 'spec_helper'

describe DBus::Systemd::Unit::Scope do
  it 'sets the right interface' do
    expect(DBus::Systemd::Unit::Scope::INTERFACE).to eq 'org.freedesktop.systemd1.Scope'
  end
end
