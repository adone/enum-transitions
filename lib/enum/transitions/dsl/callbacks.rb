module Enum
  module Transitions
    module DSL
      class Callbacks
        def initialize(config, transition)
          @config = config
          @transition = transition
        end

        def before(&block)
          @config.callbacks[@transition] << [:before, block]
        end

        def after(&block)
          @config.callbacks[@transition] << [:after, block]
        end
      end
    end
  end
end
