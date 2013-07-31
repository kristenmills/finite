require 'spec_helper'

describe Finite::Transition do
  it 'has a to and a from' do
    transition = Finite::Transition.new({from: :state1, to: :state2})
    expect(transition.from).to eq(:state1)
    expect(transition.to).to eq(:state2)
  end

  it 'equals transitions with the same to and from' do
    transition1 = Finite::Transition.new({from: :state1, to: :state2})
    transition2 = Finite::Transition.new({from: :state1, to: :state3})
    transition3 = Finite::Transition.new({from: :state4, to: :state2})
    transition4 = Finite::Transition.new({from: :state1, to: :state2})

    expect(transition1).not_to eq(transition2)
    expect(transition1).not_to eq(transition3)
    expect(transition1).to eq(transition4)
  end
end