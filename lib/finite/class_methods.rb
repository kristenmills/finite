module Finite
  # The class methods for any class that include the finite base
  module ClassMethods
    # The finite method for the dsl
    #
    # @param opts [Hash] any options including initial state
    # @param block [Block] the block of code that creates the state machine
    def finite(opts, &block)
      StateMachine.machines ||= Hash.new
      StateMachine.machines[self] = StateMachine.new(opts[:initial], &block)
    end
  end
end