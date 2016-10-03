require_relative '../helpers'
require_relative '../mixin'
require_relative 'machine'
require_relative 'image'

module DBus
  module Systemd
    module Machined
      INTERFACE = 'org.freedesktop.machine1'

      class Manager
        NODE = '/org/freedesktop/machine1'
        INTERFACE = 'org.freedesktop.machine1.Manager'

        MACHINE_INDICES = {
          name: 0,
          class: 1,
          service_id: 2,
          object_path: 3
        }

        IMAGE_INDICES = {
          name: 0,
          type: 1,
          read_only: 2,
          creation_time: 3,
          modification_time: 4,
          disk_space: 5,
          object_path: 6
        }

        include Systemd::Mixin::MethodMissing

        attr_reader :service

        def initialize(bus = Systemd::Helpers.system_bus)
          @service = bus.service(Machined::INTERFACE)
          @object = @service.object(NODE)
                            .tap(&:introspect)
        end

        def machines
          self.ListMachines.first.map { |m| map_machine(m) }
        end

        def machine(name)
          Machine.new(name, self)
        end

        def get_machine_by_path(path)
          obj = @service.object(path)
                        .tap(&:introspect)
          Machine.new(obj.Get(Machine::INTERFACE, 'Name').first, self)
        end

        def map_machine(machine_array)
          Systemd::Helpers.map_array(machine_array, MACHINE_INDICES)
        end

        def images
          self.ListImages.first.map { |i| map_image(i) }
        end

        def image(name)
          Image.new(name, self)
        end

        def get_image_by_path(path)
          obj = @service.object(path)
                        .tap(&:introspect)
          Image.new(obj.Get(Image::INTERFACE, 'Name').first, self)
        end

        def map_image(image_array)
          Systemd::Helpers.map_array(image_array, IMAGE_INDICES)
        end
      end
    end
  end
end
