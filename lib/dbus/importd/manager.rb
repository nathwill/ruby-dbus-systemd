require_relative '../systemd/method_missing'
require_relative '../systemd/bus'
require_relative 'transfer'

module DBus
  module Importd
    class Manager
      NODE = '/org/freedesktop/import1'
      INTERFACE = 'org.freedesktop.import1.Manager'

      TRANSFER_INDICES = {
        id: 0,
        operation: 1,
        remote_file: 2,
        machine_name: 3,
        progress: 4,
        object_path: 5
      }

      include DBus::Systemd::MethodMissing

      attr_reader :service

      def initialize(bus = Systemd::Bus.system_bus)
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
        mapped = {}

        transfer_array.each_with_index do |item, index|
          mapped[TRANSFER_INDICES.key(index)] = item
        end

        mapped
      end
    end
  end
end
