require 'spec_helper'

describe DBus::Systemd::Networkd do
  it 'sets the right service' do
    expect(DBus::Systemd::Networkd::SERVICE).to eq 'org.freedesktop.network1'
  end
end
