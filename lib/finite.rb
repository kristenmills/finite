[
  'version',
  'transition',
  'event',
  'state',
  'machine',
  'class_methods'
].each { |file| require File.join(File.dirname(__FILE__), 'finite', file) }

# The Finite module. The module that contains all the classes and methods for
# the finite gem.
module Finite

  # Get's the current state
  # @return the current state for an object
  def current_state
    machine = StateMachine.machines[self.class]
    @current_state or machine.states[machine.initial]
  end

  # Get's (and sets) the array of states
  # @return the array of states
  def states
    @states ||= StateMachine.machines[self.class].states
    @states
  end

  # Get's (and sets) the array of events
  # @return the array of events
  def events
    @events ||= StateMachine.machines[self.class].events
    @events
  end

  # Get's (and sets) the array of callbacks
  # @return the array of callbacks
  def callbacks
    @callbacks ||= StateMachine.machines[self.class].callbacks
    @callbacks
  end

  # Override included method
  def self.included(base)
    base.extend(ClassMethods)
    super
  end
end