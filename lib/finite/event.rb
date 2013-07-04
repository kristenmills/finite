module Finite

  # The event class. Represents an event in the state machine
  class Event

    attr_reader :name, :transitions, :options

    # Create an event object
    #
    # @param name [Symbol] the name of the event
    # @param block [Block] the block of code in the event
    def initialize(name, &block)
      @name = name
      @transitions = []
      instance_eval &block
    end

    # Are two events equal
    #
    # @param other [Object] the object you are comparing it to
    # @return true if they are equal false if not
    def ==(other)
      if other.is_a? Event
        @name == event.name
      else
        false
      end
    end

    private
      # The transition method for the dsl
      #
      # @param opts [Hash] the options for a transition
      def go(opts)
        @transitions << Transition.new(opts)
      end

      # Create the callback methods
      [:after, :before].each do |callback|
        define_method callback do |*args, &block|
          options[callback] ||= Array.new
          options[callback] << block
        end
      end
  end
end