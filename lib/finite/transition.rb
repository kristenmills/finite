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
  end
end