require 'spec_helper'

describe DBus::Systemd::Importd::Manager do
  it 'sets the appropriate dbus node path' do
    expect(DBus::Systemd::Importd::Manager::NODE).to eq '/org/freedesktop/import1'
  end

  it 'sets the appropriate interface' do
    expect(DBus::Systemd::Importd::Manager::INTERFACE).to eq 'org.freedesktop.import1.Manager'
  end
end
