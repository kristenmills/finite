module Finite

  # The transition class. Represents a transition between two states
  class Transition

    attr_reader :to, :from

    # Create a new transition object
    #
    # @param opts [Hash] the options for a transition. Include :to and :from
    def initialize(opts)
      @from = opts[:from]
      @to = opts[:to]
    end

    # Does this transition equal another transition?
    #
    # @param other [Transition] another transition
    # @return true if they are equal false if not
    def ==(other)
      from == other.from and to == other.to
    end
  end
end