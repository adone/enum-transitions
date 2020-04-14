module Enum
  module Transitions
    module DSL
      class Proxy
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
              transition = :"#{@config.enum}_from_#{source}_to_#{target}"
              @config.transitions[source][target] = transition
              Docile.dsl_eval(Callbacks.new(@config, transition), &block)
            end
          end
        end

        def before_leaving(*states, &block)
          states.each do |state|
            @config.callbacks[:"#{@config.enum}_leaving_#{state}"] << [:before, block]
          end
        end

        def after_leaving(*states, &block)
          states.each do |state|
            @config.callbacks[:"#{@config.enum}_leaving_#{state}"] << [:after, block]
          end
        end

        def before_entering(*states, &block)
          states.each do |state|
            @config.callbacks[:"#{@config.enum}_entering_#{state}"] << [:before, block]
          end
        end

        def after_entering(*states, &block)
          states.each do |state|
            @config.callbacks[:"#{@config.enum}_entering_#{state}"] << [:after, block]
          end
        end
      end
    end
  end
end
