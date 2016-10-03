require 'spec_helper'

describe DBus::Systemd do
  it 'has a version number' do
    expect(DBus::Systemd::VERSION).not_to be nil
  end
end
