require 'spec_helper'

describe DBus::Systemd::Importd::Transfer do
  it 'sets the right interface' do
    expect(DBus::Systemd::Importd::Transfer::INTERFACE).to eq 'org.freedesktop.import1.Transfer'
  end
end
