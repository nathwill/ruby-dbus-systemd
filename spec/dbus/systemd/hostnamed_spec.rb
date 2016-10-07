require 'spec_helper'

describe DBus::Systemd::Hostnamed do
  it 'sets the right node path' do
    expect(DBus::Systemd::Hostnamed::NODE).to eq '/org/freedesktop/hostname1'
  end

  it 'sets the right service' do
    expect(DBus::Systemd::Hostnamed::SERVICE).to eq 'org.freedesktop.hostname1'
  end

  it 'sets the right interface' do
    expect(DBus::Systemd::Hostnamed::INTERFACE).to eq 'org.freedesktop.hostname1'
  end
end
