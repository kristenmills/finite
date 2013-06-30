module Finite

  # The State Machine class. Represents the whole state machine
  class Machine
    attr_reader :states, :initial, :current_state, :events

    # Create a new state machine
    #
    # @param initial [Symbol] the initial state of this state machine
    def initialize(initial_state)
      @initial = initial
      @current_state = @initial
      @states = [@initial]
      @events = Array.new
    end

    # Add an event to the state machine
    #
    # @param event [Event] the event you are trying to add
    # @raise [Exception] if the event already exists
    def add_event event
      if events.include? event
        raise 'Event #{event.name} already exists. Rename or combine the events'
      else
        @events << event
      end
    end

    # Add a state to the the state machine if the state hasn't already been
    # created
    #
    # @param state [Symbol] the state you are trying to add
    def add_state state
      @state << State.new(state) if not @states.include? state
    end
  end
end