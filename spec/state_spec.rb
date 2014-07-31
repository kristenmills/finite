require 'spec_helper'

describe Finite::State do
  before(:each) do
    @name = :state_name
  end

  it 'has a name' do
    expect(Finite::State.new(@name).name).to eq(:state_name)
  end
  context 'equality' do
    it 'equals a symbol of the same name' do
      state = Finite::State.new(@name)
      expect(state).to eq(:state_name)
      expect(state).not_to eq(:different_name)
    end

    it 'equals a state with the same name' do
      state1 = Finite::State.new(@name)
      state2 = Finite::State.new(:different_name)
      state3 = Finite::State.new(@name)
      expect(state1).to eq(state3)
      expect(state1).not_to eq(state2)
    end

    it "doesn't equal objects that aren't states or symbols" do
      state = Finite::State.new(@name)
      expect(state).not_to eq('string')
    end
  end
  it 'has to_s and inspect methods' do
    state = Finite::State.new(@name)
    expect(state.to_s).to eq('state_name')
    expect(state.inspect).to eq(:state_name)
  end
end
