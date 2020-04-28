module Enum
  module Transitions
    class UpdateHandler
      include Naming

      # @param config [Enum::Transisions::Configuration]
      def initialize(config)
        @config = config
      end

      def around_update(model)
        source, target = model.changes[@config.enum]
        transition = @config.transitions.dig(source, target)

        raise Errors::TransitionNotAllowed if transition.nil?

        model.run_callbacks transition do
          model.run_callbacks leaving_event(source) do
            model.run_callbacks entering_event(target) do
              yield
            end
          end
        end
      end
    end
  end
end
