require 'spec_helper'

describe DBus::Systemd::Job do
  it 'sets the right interface' do
    expect(DBus::Systemd::Job::INTERFACE).to eq 'org.freedesktop.systemd1.Job'
  end
end
