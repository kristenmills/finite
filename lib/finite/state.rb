module Finite

  # The State class. Represents a state in the state machine.
  class State
    attr_reader :name

    # Create a new state
    #
    # @param name [Symbol] the name of the state
    def initialize(name)
      @name = name
    end

    # Overide the == method for state
    #
    # @param state [Object] the state your comparing to
    # @return true if they are equal false if not
    def ==(state)
      if state.is_a? Symbol
        @name == state
      elsif state.is_a? State
        @name == state.name
      else
        false
      end
    end

    # overrriden for puts and print
    def to_s
      @name.to_s
    end

    # Overridden for p
    def inspect
      @name
    end
  end
end