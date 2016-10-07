require 'spec_helper'

describe DBus::Systemd::Machined do
  it 'sets the right service' do
    expect(DBus::Systemd::Machined::SERVICE).to eq 'org.freedesktop.machine1'
  end
end
