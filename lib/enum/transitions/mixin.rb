module Enum
  module Transitions
    class Mixin < Module
      include ActiveSupport::Concern

      # @param config [Enum::Transitions::Configuration]
      def initialize(config)
        @_dependencies = []
        @_enum = config.enum

        included do
          define_callbacks(*config.callbacks.keys)

          config.callbacks.each_pair do |event, callbacks|
            callbacks.each do |kind, block|
              set_callback(event, kind, &block)
            end
          end

          around_update UpdateHandler.new(config), if: :"#{config.enum}_changed?"
        end
      end

      def inspect
        "Enum::Transitions::Mixin[#{@_enum}]"
      end
    end
  end
end
