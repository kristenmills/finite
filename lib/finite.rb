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

  # Sets the current state on initialization
  def initialize
    @current_state = State.new(StateMachine.machines[self.class].initial)
  end

  def current_state
    @current_state.name
  end

  # Override included method
  def self.included(base)
    base.extend(ClassMethods)
    super
  end
end