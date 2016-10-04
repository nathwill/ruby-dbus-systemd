require 'spec_helper'

describe DBus::Systemd::Machined do
  it 'sets the right interface' do
    expect(DBus::Systemd::Machined::INTERFACE).to eq 'org.freedesktop.machine1'
  end
end
