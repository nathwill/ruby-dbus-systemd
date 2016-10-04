require 'spec_helper'

describe DBus::Systemd::Importd do
  it 'sets the right interface' do
    expect(DBus::Systemd::Importd::INTERFACE).to eq 'org.freedesktop.import1'
  end
end
