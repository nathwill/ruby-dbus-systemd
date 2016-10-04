require 'spec_helper'

describe DBus::Systemd::Resolved::Link do
  it 'sets the right interface' do
    expect(DBus::Systemd::Resolved::Link::INTERFACE).to eq 'org.freedesktop.resolve1.Link'
  end
end
