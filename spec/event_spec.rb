require 'spec_helper'

describe Finite::Event do
  before(:each) do
    @block = Proc.new do
      go from: :state1, to: :state2
      after do
        'hello again'
      end
      before do
        'hello for the first time'
      end
    end
  end

  it 'has a name' do
    event = Finite::Event.new(:event1, &@block)
    event.name.should be(:event1)
  end

  context 'equality' do
    it 'equals symbols that have the same name' do
      event = Finite::Event.new(:event1, &@block)
      event.should eq(:event1)
      event.should_not eq(:event2)
    end

    it 'equals events with the same name' do
      event1 = Finite::Event.new(:event1, &@block)
      event2 = Finite::Event.new(:event2, &@block)
      event3 = Finite::Event.new(:event1, &@block)

      event1.should eq(event3)
      event1.should_not eq(event2)
    end

    it "doesn't equal things that aren't symbols or events" do
      event = Finite::Event.new(:event1, &@block)
      event.should_not eq('string')
    end
  end

  it 'should create transitions' do
    event = Finite::Event.new(:event1, &@block)
    event.transitions.count.should be(1)
    event.transitions[:state1].to.should eq(:state2)
    event.transitions[:state1].from.should eq(:state1)
  end

  it 'should create callbacks' do
    event = Finite::Event.new(:event1, &@block)

    event.callbacks[:before].should_not be_nil
    event.callbacks[:after].should_not be_nil
    event.callbacks[:after][0].call.should eq('hello again')
    event.callbacks[:before][0].call.should eq('hello for the first time')
  end
end