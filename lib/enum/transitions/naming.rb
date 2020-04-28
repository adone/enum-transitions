module Enum
  module Transitions
    module Naming
      def transition_event(source, target)
        :"#{@config.enum}_from_#{source}_to_#{target}"
      end

      def leaving_event(state)
        :"#{@config.enum}_leaving_#{state}"
      end

      def entering_event(state)
        :"#{@config.enum}_entering_#{state}"
      end
    end
  end
end
