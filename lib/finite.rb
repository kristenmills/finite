require '../lib/finite/version'
require '../lib/finite/transition'
require '../lib/finite/event'
require '../lib/finite/state'
require '../lib/finite/machine'

# The Finite module. The module that contains all the classes and methods for
# the finite gem.
module Finite
  attr_reader :machine

  # The finite method for the dsl
  #
  # @param opts [Hash] any options including initial state
  # @param block [Block] the block of code that creates the state machine
  def finite(opts, &block)
    @machine = StateMachine.new(opts[:initial], &block)
  end
end