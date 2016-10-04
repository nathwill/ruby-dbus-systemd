#
# Copyright (C) 2016 Nathan Williams <nath.e.will@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
# the Software, and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
# FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
# IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#
require 'dbus'

module DBus
  module Systemd
    module Helpers
      #
      # get an instance of the system bus
      #
      # @return [DBus::SystemBus]
      def system_bus
        DBus::SystemBus.instance
      end

      #
      # get an instance of the session bus
      #
      # @return [DBus::SessionBus]
      def session_bus
        DBus::SessionBus.instance
      end

      #
      # map an array to a hash from an index map
      #
      # @param array [Array] array to be mapped
      # @param map [Hash] map of positional elements to array indices
      # @return [Hash] hash with keys from map and values from array
      def map_array(array, map)
        mapped = {}

        array.each_with_index do |item, index|
          mapped[map.key(index)] = item
        end

        mapped
      end

      module_function :system_bus, :session_bus, :map_array
    end
  end
end
