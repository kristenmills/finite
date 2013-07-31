module Finite
  # The State Machine class. Represents the whole state machine
  class StateMachine

    class << self
      attr_accessor :machines
    end

    attr_reader :states, :initial, :events, :callbacks

    # Create a new state machine
    #
    # @param initial_state [Symbol] the initial state of this state machine
    # @param klass [Class] the class of the state machine
    # @param block [Block] the block of code that creates it
    def initialize(initial_state, klass, &block)
      @class = klass
      @initial = initial_state
      @states = Hash.new
      @events = Hash.new
      @callbacks = {before: Hash.new , after: Hash.new}
      instance_eval &block
    end

    # Add an event to the state machine
    #
    # @param event_name [Symbol] the event you are trying to add
    # @param block [Block] the block of code that creates an event
    # @raise [Exception] if the event already exists
    def add_event(event_name, &block)
      # We don't want to randomly override things that we shouldn't
      raise "Method already taken can_#{event_name}?" if @class.methods.include?(:"can_#{event_name}?")
      raise "Method already taken #{event_name}" if @class.methods.include?(:"#{event_name}")
      raise 'Event #{event_name} already exists. Rename or combine the events' if events.include? event_name
      event = Event.new(event_name, &block)
      @events[event_name] = event
      event.transitions.each_value do |transition|
        add_state transition.to
        add_state transition.from
      end
      @class.send(:define_method, :"can_#{event_name}?") do
        event.transitions.key? current_state.name
      end
      @class.send(:define_method, :"#{event_name}") do
        if event.transitions.key? current_state.name

          event.callbacks[:before].each do |callback|
            self.instance_eval &callback
          end

          if callbacks[:before].key? :all
            callbacks[:before][:all].each do |callback|
              self.instance_eval &callback
            end
          end

          new_state = states[event.transitions[current_state.name].to]

          if callbacks[:before].key? new_state.name
            callbacks[:before][new_state.name].each do |callback|
              self.instance_eval &callback
            end
          end
          @current_state = new_state

          if callbacks[:after].key? :all
            callbacks[:after][:all].each do |callback|
              self.instance_eval &callback
            end
          end
          if callbacks[:after].key? current_state.name
            callbacks[:after][current_state.name].each do |callback|
              self.instance_eval &callback
            end
          end

          event.callbacks[:after].each do |callback|
            self.instance_eval &callback
          end
        else
          raise 'Invalid Transition'
        end
      end
    end

    # Add a state to the the state machine if the state hasn't already been
    # created
    #
    # @param state [Symbol] the state you are trying to add
    def add_state(state)
      if not @states.include? state
        # Prevents arbitrarily overriding methods that you shouldn't be
        raise "Method already taken #{state}?" if @class.methods.include?(:"#{state}?")
        @states[state] = State.new(state)
        @class.send(:define_method, :"#{state}?"){current_state == state}
      end
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