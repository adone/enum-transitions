module Enum
  module Transitions
    class UpdateHandler
      # @param config [Enum::Transisions::Configuration]
      def initialize(config)
        @config = config
      end

      def around_update(model)
        source, target = model.changes[@config.enum]
        transition = @config.transitions.dig(source, target)

        raise Errors::TransitionNotAllowed if transition.nil?

        run_callbacks transition do
          run_callbacks :"leave_#{source}_#{@config.enum}" do
            run_callbacks :"enter_#{target}_#{@config.enum}" do
              yield
            end
          end
        end
      end
    end
  end
end
