require 'enum/transitions/version'

module Enum
  module Transitions
    autoload :DSL
    autoload :Machine
    autoload :UpdateHandler
    autoload :Configuration

    module Errors
      TransitionNotAllowed = Class.new(RuntimeError)
    end
  end
end
