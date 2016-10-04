require 'spec_helper'

describe DBus::Systemd::Resolved do
  it 'sets the right interface' do
    expect(DBus::Systemd::Resolved::INTERFACE).to eq 'org.freedesktop.resolve1'
  end
end
