require 'spec_helper'

describe DBus::Systemd::Helpers do
  let(:raw_array) do
    ["Fedora-23", "raw", false, 1446171608000000, 1446171608000000, 589676544, "/org/freedesktop/machine1/image/Fedora_2d23"]
  end

  let(:converted) do
    {:name=>"Fedora-23", :type=>"raw", :read_only=>false, :creation_time=>1446171608000000, :modification_time=>1446171608000000, :disk_space=>589676544, :object_path=>"/org/freedesktop/machine1/image/Fedora_2d23"}
  end

  it 'maps positional array to named hash' do
    expect(DBus::Systemd::Helpers.map_array(raw_array, DBus::Systemd::Machined::Manager::IMAGE_INDICES)).to eq converted
  end
end
