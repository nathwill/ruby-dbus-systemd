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
module DBus
  module Systemd
    module Mixin
      module MethodMissing
        # @return DBus::ProxyObject
        # @api private
        attr_reader :object

        #
        # use method_missing to proxy methods to
        # the dbus proxy object interface methods
        #
        def method_missing(name, *args, &blk)
          if @object.respond_to?(name)
            @object.send(name, *args, &blk)
          else
            super
          end
        end

        #
        # fix respond_to to also check the dbus methods
        #
        def respond_to_missing?(*args)
          @object.respond_to?(*args) || super
        end
      end

      module Properties
        #
        # fetches properties from a named interface
        #
        # @param interface [String], interface to get properties from
        # @return [Hash] interface property hash
        def properties(interface = self.class::INTERFACE)
          self.GetAll(interface).first
        end
      end
    end
  end
end
