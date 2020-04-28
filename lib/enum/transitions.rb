require 'enum/transitions/version'
require 'active_support'

module Enum
  module Transitions
    extend ActiveSupport::Autoload

    autoload :DSL
    autoload :Mixin
    autoload :Naming
    autoload :Machine
    autoload :UpdateHandler
    autoload :Configuration

    module Errors
      TransitionNotAllowed = Class.new(RuntimeError)
    end
  end
end
