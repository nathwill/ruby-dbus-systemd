require 'spec_helper'

describe DBus::Systemd::Machined::Machine do
  it 'sets the right interface' do
    expect(DBus::Systemd::Machined::Machine::INTERFACE).to eq 'org.freedesktop.machine1.Machine'
  end
end
