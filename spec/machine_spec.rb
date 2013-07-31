require 'spec_helper'

describe Finite::StateMachine do
  before(:each) do
    @elevator = Elevator.new
    @machine = Finite::StateMachine.machines[Elevator]
  end

  context 'adding events' do
    it 'has events' do
      expect(@machine.events.count).to be(10)
    end

    it 'cannot have events with the same name' do
      expect{@machine.add_event(:prepare){}}.to raise_error
    end

    it 'cannot be stupid with your event naming' do
      expect{@machine.add_event(:to_s)}.to raise_error
    end

    it 'increases in size when an event is added' do
      @machine.add_event(:random_event){}
      expect(@machine.events.count).to be(11)
    end
    it 'adds the proper helper methods' do
      expect(@elevator.methods).to include(:random_event)
      expect(@elevator.methods).to include(:can_random_event?)
    end
  end

  context 'adding states' do
    it 'has states' do
      expect(@machine.states.count).to be(9)
    end

    it 'cannot be stupid with your state naming' do
      expect{@machine.add_state(:const_defined){}}.to raise_error
    end

    it 'cannot have states with the same name' do
      @machine.add_state(:doors_closing){}
      expect(@machine.states.count).to be(9)
    end

    it 'increases in size when a state is added' do
      @machine.add_state(:random_state){}
      expect(@machine.states.count).to be(10)
    end

    it 'adds the proper helper method' do
      expect(@elevator.methods).to include(:random_state?)
    end
  end

  context 'callbacks' do
    it 'has after and before keys' do
      expect(@machine.callbacks).to include(:before)
      expect(@machine.callbacks).to include(:after)
    end

    it 'adds callbacks' do
      expect(@machine.callbacks[:before]).to include(:doors_closing)
      expect(@machine.callbacks[:before]).to include(:doors_opening)
    end
  end
end