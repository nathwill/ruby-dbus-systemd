require 'spec_helper'

describe DBus::Systemd::Networkd::Link do
  it 'sets the right interface' do
    expect(DBus::Systemd::Networkd::Link::INTERFACE).to eq 'org.freedesktop.network1.Link'
  end
end
