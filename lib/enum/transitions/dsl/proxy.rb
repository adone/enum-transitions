module Enum
  module Transitions
    module DSL
      class Proxy
        include Naming

        # @param states [Array<String>]
        def self.embed(states)
          Class.new(self) do
            states.each do |state|
              define_method(state) { state }
            end
          end
        end

        # @param config [Enum::Transitions::Configuration]
        def initialize(config)
          @config = config
        end

        # @param transitions[Hash{Array<Symbol>=>Array<Symbol>}]
        def allow(transitions, &block)
          transitions.each_pair do |sources, targets|
            Array(sources).product(Array(targets)) do |source, target|
              transition = transition_event(source, target)

              @config.transitions[source][target] = transition
              @config.callbacks[transition] ||= []
              @config.callbacks[leaving_event(source)] ||= []
              @config.callbacks[entering_event(target)] ||= []

              Docile.dsl_eval(Callbacks.new(@config, transition), &block)
            end
          end
        end

        def before_leaving(*states, &block)
          states.each do |state|
            @config.callbacks[leaving_event(state)] << [:before, block]
          end
        end

        def after_leaving(*states, &block)
          states.each do |state|
            @config.callbacks[leaving_event(state)] << [:after, block]
          end
        end

        def before_entering(*states, &block)
          states.each do |state|
            @config.callbacks[entering_event(state)] << [:before, block]
          end
        end

        def after_entering(*states, &block)
          states.each do |state|
            @config.callbacks[entering_event(state)] << [:after, block]
          end
        end
      end
    end
  end
end
