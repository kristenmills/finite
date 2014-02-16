require 'spec_helper'

describe Elevator do
  before(:each) do
    @elevator = Elevator.new
  end

  it 'has a state machine' do
    expect(Finite::StateMachine.machines[Elevator]).to_not be_nil
  end

  context 'states' do
    it 'has a current state' do
      expect(@elevator.current_state).to_not be_nil
      expect(@elevator.current_state).to eq(:idle)
    end

    it 'has methods to tell whether it is in a state or not' do
      expect(@elevator.idle?).to be_true
      expect(@elevator.moving?).to be_false
    end

    it 'can access all states' do
      expect(@elevator.states).to_not be_nil
      expect(@elevator.states.count).to be(9)
    end
  end

  context 'events' do
    it 'can access all events' do
      expect(@elevator.events).to_not be_nil
      expect(@elevator.events.count).to be(10)
    end

    it 'can access possible events for a given state' do
      expect(@elevator.possible_events).to eq([:prepare])
    end

    it 'has methods to tell whether an event can be performed' do
      expect(@elevator.can_prepare?).to be_true
      expect(@elevator.can_go_up?).to be_false
    end

    it 'can perform events' do
      @elevator.prepare
      expect(@elevator.current_state).to eq(:doors_closing)
      expect(@elevator.doors_closing?).to be_true
      expect(@elevator.idle?).to be_false
      expect(@elevator.possible_events).to eq([:go_up,:go_down])
      expect{@elevator.start}.to raise_error
      @elevator.go_down
      expect(@elevator.can_start?).to be_true
      @elevator.start
      @elevator.approach
      @elevator.stop
    end

    it 'will respond to conditions' do
      @elevator.broken = true
      expect{@elevator.prepare}.to raise_error(Finite::Error)
      @elevator.broken = false
      expect{@elevator.prepare}.to_not raise_error
    end
  end

end