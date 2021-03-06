module Finite

  # The transition class. Represents a transition between two states
  class Transition

    attr_reader :to, :from, :condition

    # Create a new transition object
    #
    # @param opts [Hash] the options for a transition. Include :to, :from, and :if
    def initialize(opts)
      @from = opts[:from]
      @to = opts[:to]
      @condition = opts[:if]
    end

    # Does this transition equal another transition?
    #
    # @param other [Transition] another transition
    # @return true if they are equal false if not
    def ==(other)
      from == other.from and to == other.to and condition == other.condition
    end
  end
end