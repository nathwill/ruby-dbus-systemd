require 'spec_helper'

describe DBus::Systemd::Unit::Path do
  it 'sets the right interface' do
    expect(DBus::Systemd::Unit::Path::INTERFACE).to eq 'org.freedesktop.systemd1.Path'
  end
end
