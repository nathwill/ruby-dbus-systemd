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
require_relative 'machine'
require_relative 'image'

module DBus
  module Systemd
    module Machined
      # machined dbus service
      SERVICE = 'org.freedesktop.machine1'

      class Manager
        # machined manager dbus object node path
        NODE = '/org/freedesktop/machine1'

        # machined manager dbus interface
        INTERFACE = 'org.freedesktop.machine1.Manager'

        # machine array index map as returned by ListMachines
        MACHINE_INDICES = {
          name: 0,
          class: 1,
          service_id: 2,
          object_path: 3
        }.freeze

        # image array index map as returned by ListImages
        IMAGE_INDICES = {
          name: 0,
          type: 1,
          read_only: 2,
          creation_time: 3,
          modification_time: 4,
          disk_space: 5,
          object_path: 6
        }.freeze

        include Systemd::Mixin::MethodMissing
        include Systemd::Mixin::Properties

        # @return [DBus::Service]
        # @api private
        attr_reader :service

        #
        # Create machined Manager dbus proxy object
        #
        # @param bus [DBus::SystemBus, DBus::SessionBus] dbus instance
        def initialize(bus = Systemd::Helpers.system_bus)
          @service = bus.service(Machined::SERVICE)
          @object = @service.object(NODE)
          @object.default_iface = INTERFACE
          @object.introspect
        end

        #
        # array of machines with mapped properties
        #
        # @return [Array] array of machine property hashes
        def machines
          self.ListMachines.first.map { |m| map_machine(m) }
        end

        #
        # get machine dbus proxy object by machine name
        #
        # @param name [String] machine name
        # @return [DBus::Systemd::Machined::Machine] machine instance
        def machine(name)
          Machine.new(name, self)
        end

        #
        # get machine dbus proxy object by dbus node path
        #
        # @param path [String] machine dbus node path
        # @return [DBus::Systemd::Machined::Machine] machine instance
        def get_machine_by_path(path)
          obj = @service.object(path)
                        .tap(&:introspect)
          Machine.new(obj.Get(Machine::INTERFACE, 'Name').first, self)
        end

        #
        # map machine property array from ListMachines to indexed property hash
        #
        # @param machine_array [Array] machine property array as returned by ListMachines
        # @return [Hash] hash containing mapped machine properties
        def map_machine(machine_array)
          Systemd::Helpers.map_array(machine_array, MACHINE_INDICES)
        end

        #
        # get mapped array of images
        #
        # @return [Array] array of mapped image property hashes
        def images
          self.ListImages.first.map { |i| map_image(i) }
        end

        #
        # get image proxy object by name
        #
        # @param name [String] image name
        # @return [DBus::Systemd::Machined::Machine] image dbus proxy object
        def image(name)
          Image.new(name, self)
        end

        #
        # get image dbus proxy object by dbus node path
        #
        # @param path [String] image dbus node path
        # @return [DBus::Systemd::Machined::Image] image dbus proxy object
        def get_image_by_path(path)
          obj = @service.object(path)
                        .tap(&:introspect)
          Image.new(obj.Get(Image::INTERFACE, 'Name').first, self)
        end

        #
        # map image array as returned by ListImages to property hash
        #
        # @param image_array [Array] image property array as returned by ListImages
        # @return [Hash] image property hash
        def map_image(image_array)
          Systemd::Helpers.map_array(image_array, IMAGE_INDICES)
        end
      end
    end
  end
end
