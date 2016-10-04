require 'spec_helper'

describe DBus::Systemd::Helpers do
  let(:raw_array) { ['Black', 'Cat', 4] }
  let(:array_map) { { color: 0, animal: 1, age: 2 } }
  let(:converted) { { color: 'Black', animal: 'Cat', age: 4 } }

  it 'maps positional array to named hash' do
    expect(DBus::Systemd::Helpers.map_array(raw_array, array_map)).to eq converted
  end
end
