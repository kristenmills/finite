require 'spec_helper'

describe Finite::State do
  before(:each) do
    @name = :state_name
  end

  it 'has a name' do
    Finite::State.new(@name).name.should eq(:state_name)
  end
  context 'equality' do
    it 'equals a symbol of the same name' do
      state = Finite::State.new(@name)
      state.should eq(:state_name)
      state.should_not eq(:different_name)
    end

    it 'equals a state with the same name' do
      state1 = Finite::State.new(@name)
      state2 = Finite::State.new(:different_name)
      state3 = Finite::State.new(@name)
      state1.should eq(state3)
      state1.should_not eq(state2)
    end

    it "doesn't equal objects that aren't states or symbols" do
      state = Finite::State.new(@name)
      state.should_not eq('string')
    end
  end
end