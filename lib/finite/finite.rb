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

  # Get's all the possible events you can perform
  # @return any event that you can perform given your state
  def possible_events
    pos = Array.new
    events.each_value{|event| pos << event if event.transitions.key?(current_state.name)}
    pos
  end
end