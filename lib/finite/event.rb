module Finite

  # The event class. Represents an event in the state machine
  class Event

    attr_reader :name, :transitions, :callbacks

    # Create an event object
    #
    # @param name [Symbol] the name of the event
    # @param block [Block] the block of code in the event
    def initialize(name, &block)
      @name = name
      @transitions = Hash.new
      @callbacks = {before: Array.new, after: Array.new}
      instance_eval &block
    end

    # Are two events equal
    #
    # @param event [Object] the object you are comparing it to
    # @return true if they are equal false if not
    def ==(event)
      if event.is_a? Event
        @name == event.name
      elsif event.is_a? Symbol
        @name == event
      else
        false
      end
    end

    private
    # The transition method for the dsl
    #
    # @param opts [Hash] the options for a transition
    def go(opts)
      options = []
      if opts[:from].is_a? Array
        opts[:from].each do |from|
          options << {from: from, to: opts[:to]}
        end
      else
        options << opts
      end
      options.each do |opt|
        @transitions[opt[:from]] = Transition.new(opt)
      end
    end

    # Create the callback methods
    [:after, :before].each do |callback|
      define_method callback do |*args, &block|
        @callbacks[callback] << block
      end
    end
  end
end