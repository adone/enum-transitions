module Enum
  module Transitions
    class Configuration
      attr_reader :enum, :states, :transitions, :callbacks

      # @param enum [String]
      # @param states [Array<String>]
      def initialize(enum, states)
        @enum   = enum
        @states = states
        @transitions = {}
        @callbacks   = {}
      end

      def with_safe_nesting
        @transitions.default_proc = ->(hash, key) { hash[key] = {} }
        @callbacks.default_proc = ->(hash, key) { hash[key] = [] }
        yield
      ensure
        @callbacks.default_proc = nil
        @transitions.default_proc = nil
      end
    end
  end
end
