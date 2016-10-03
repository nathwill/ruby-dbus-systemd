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
      INTERFACE = 'org.freedesktop.import1'

      class Manager
        NODE = '/org/freedesktop/import1'
        INTERFACE = 'org.freedesktop.import1.Manager'

        TRANSFER_INDICES = {
          id: 0,
          operation: 1,
          remote_file: 2,
          image_name: 3,
          progress: 4,
          object_path: 5
        }

        include Systemd::Mixin::MethodMissing
        include Systemd::Mixin::Properties

        attr_reader :service

        def initialize(bus = Systemd::Helpers.system_bus)
          @service = bus.service(Importd::INTERFACE)
          @object = @service.object(NODE)
                            .tap(&:introspect)
        end

        def transfers
          self.ListTransfers.first.map { |t| map_transfer(t) }
        end

        def transfer(id)
          Transfer.new(id, self)
        end

        def get_transfer_by_path(path)
          obj = @service.object(path)
                        .tap(&:introspect)
          Transfer.new(obj.Get(Transfer::INTERFACE, 'Id').first, self)
        end

        def map_transfer(transfer_array)
          Systemd::Helpers.map_array(transfer_array, TRANSFER_INDICES)
        end
      end
    end
  end
end