require 'spec_helper'

describe DBus::Systemd::Importd do
  it 'sets the right service' do
    expect(DBus::Systemd::Importd::SERVICE).to eq 'org.freedesktop.import1'
  end
end
