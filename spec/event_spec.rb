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
    expect(event.name).to eq(:event1)
  end

  context 'equality' do
    it 'equals symbols that have the same name' do
      event = Finite::Event.new(:event1, &@block)
      expect(event).to eq(:event1)
      expect(event).not_to eq(:event2)
    end

    it 'equals events with the same name' do
      event1 = Finite::Event.new(:event1, &@block)
      event2 = Finite::Event.new(:event2, &@block)
      event3 = Finite::Event.new(:event1, &@block)

      expect(event1).to eq(event3)
      expect(event1).not_to eq(event2)
    end

    it "doesn't equal things that aren't symbols or events" do
      event = Finite::Event.new(:event1, &@block)
      expect(event).not_to eq('string')
    end
  end

  it 'should create transitions' do
    event = Finite::Event.new(:event1, &@block)
    expect(event.transitions.count).to eql(1)
    expect(event.transitions[:state1].to).to eq(:state2)
    expect(event.transitions[:state1].from).to eq(:state1)
  end

  it 'should create callbacks' do
    event = Finite::Event.new(:event1, &@block)

    expect(event.callbacks[:before]).not_to be_nil
    expect(event.callbacks[:after]).not_to be_nil
    expect(event.callbacks[:after][0].call).to eq('hello again')
    expect(event.callbacks[:before][0].call).to eq('hello for the first time')
  end

  it 'has to_s and inspect methods' do
    event = Finite::Event.new(:event, &@block)
    expect(event.to_s).to eq('event')
    expect(event.inspect).to eq(:event)
  end
end
