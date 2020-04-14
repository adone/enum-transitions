module Enum
  module Transitions
    module DSL
      extend ActiveSupport::Concern
      extend ActiveSupport::Autoload

      autoload :Proxy
      autoload :Callbacks

      class_methods do
        def transitions(enum:, &block)
          states = public_send(enum.pluralize).keys
          config = Configuration.new(enum.to_s, states)
          proxy  = Proxy.embed(states).new(config)

          config.with_safe_nesting do
            Docile.dsl_eval(proxy, &block)
          end

          prepend Mixin.new(config)
        end
      end
    end
  end
end
