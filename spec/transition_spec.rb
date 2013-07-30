require 'spec_helper'

describe Finite::Transition do
  it 'has a to and a from' do
    transition = Finite::Transition.new({from: :state1, to: :state2})
    transition.from.should be(:state1)
    transition.to.should be(:state2)
  end

  it 'equals transitions with the same to and from' do
    transition1 = Finite::Transition.new({from: :state1, to: :state2})
    transition2 = Finite::Transition.new({from: :state1, to: :state3})
    transition3 = Finite::Transition.new({from: :state4, to: :state2})
    transition4 = Finite::Transition.new({from: :state1, to: :state2})

    transition1.should_not eq(transition2)
    transition2.should_not eq(transition3)
    transition1.should eq(transition4)
  end
end