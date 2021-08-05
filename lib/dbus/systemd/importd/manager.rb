# frozen_string_literal: true

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
require_relative '../helpers'
require_relative '../mixin'
require_relative 'transfer'

module DBus
  module Systemd
    module Importd
      # the importd dbus interface
      SERVICE = 'org.freedesktop.import1'

      class Manager
        # the importd manager dbus node path
        NODE = '/org/freedesktop/import1'

        # the importd manager dbus interface
        INTERFACE = 'org.freedesktop.import1.Manager'

        # index mapping of transfer array returned from ListTransfers()
        TRANSFER_INDICES = {
          id: 0,
          operation: 1,
          remote_file: 2,
          image_name: 3,
          progress: 4,
          object_path: 5
        }.freeze

        include Systemd::Mixin::MethodMissing
        include Systemd::Mixin::Properties

        # @return [DBus::Service]
        # @api private
        attr_reader :service

        #
        # Creates a new Manager object for interfacing with
        # the hostnamed Manager interface
        #
        # @param bus [DBus::SystemBus, DBus::SessionBus] dbus instance
        def initialize(bus = Systemd::Helpers.system_bus)
          @service = bus.service(Importd::SERVICE)
          @object = @service.object(NODE)
          @object.default_iface = INTERFACE
          @object.introspect
        end

        #
        # return a list of mapped transfers
        #
        # @return [Array] array of hashes with transfer data
        def transfers
          self.ListTransfers.first.map { |t| map_transfer(t) }
        end

        #
        # Create a transfer object from a transfer id
        #
        # @param id [Integer] transfer id
        # @return [DBus::Systemd::Importd::Transfer] importd transfer object
        def transfer(id)
          Transfer.new(id, self)
        end

        #
        # Create a transfer object from the transfer node path
        #
        # @param path [String] transfer dbus node path
        # @return [DBus::Systemd::Importd::Transfer] importd transfer object
        def get_transfer_by_path(path)
          obj = @service.object(path)
                        .tap(&:introspect)
          Transfer.new(obj.Get(Transfer::INTERFACE, 'Id').first, self)
        end

        #
        # map a transfer array as returned from ListTransfers
        # to a hash with keys from TRANSER_INDICES
        #
        # @param transfer_array [Array] a transfer array
        # @return [Hash] mapped transfer array to named fields
        def map_transfer(transfer_array)
          Systemd::Helpers.map_array(transfer_array, TRANSFER_INDICES)
        end
      end
    end
  end
end
