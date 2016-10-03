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
