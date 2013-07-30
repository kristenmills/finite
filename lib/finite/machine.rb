module Finite
  # The State Machine class. Represents the whole state machine
  class StateMachine

    class << self
      attr_accessor :machines
    end

    attr_reader :states, :initial, :events, :callbacks

    # Create a new state machine
    #
    # @param initial [Symbol] the initial state of this state machine
    def initialize(initial_state, klass, &block)
      @class = klass
      @initial = initial_state
      @states = Array.new
      @events = Array.new
      @callbacks = {before: Hash.new , after: Hash.new}
      instance_eval &block
    end

    # Add an event to the state machine
    #
    # @param event_name [Symbol] the event you are trying to add
    # @param block [Block] the block of code that creates an event
    # @raise [Exception] if the event already exists
    def add_event event_name, &block
      if events.include? event_name
        raise 'Event #{event_name} already exists. Rename or combine the events'
      else
        event = Event.new(event_name, &block)
        @events << event
      end
      event.transitions.each do |transition|
        add_state transition.to
        add_state transition.from
      end
    end

    # Add a state to the the state machine if the state hasn't already been
    # created
    #
    # @param state [Symbol] the state you are trying to add
    def add_state state
      @states << State.new(state) if not @states.include? state
      @class.send(:define_method, :"#{state}?"){@current_state == state}
    end

    private
    # The event method for the dsl
    #
    # @param name [Symbol] the name of the event
    # @param block [Block] the block of code that creates events
    def event(name, &block)
      add_event name, &block
    end

    # Create the callback methods
    [:after, :before].each do |callback|
      define_method callback do |*args, &block|
        if args.count > 0
          callbacks[callback][args[0]] ||= Array.new
          callbacks[callback][args[0]] << block
        else
          callbacks[callback][:all] ||= Array.new
          callbacks[callback][:all] << block
        end
      end
    end
  end
end