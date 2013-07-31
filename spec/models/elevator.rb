
class Elevator
  include Finite

  def initialize
    @before_called = 0
    @after_called = 0
  end

  finite initial: :idle do

    before :doors_closing do
      puts 'Doors Closing!'
    end

    before :doors_opening do
      puts 'Doors Opening!'
    end

    after :doors_closing do
      puts "I'm no longer idle"
    end

    before do
      @before_called += 1
    end

    after do
      @after_called += 1
    end


    event :prepare do
      go from: :idle, to: :doors_closing
    end

    event :go_up do
      go from: :doors_closing, to: :elevator_going_up
      after do
        puts 'Going Up!'
      end
    end

    event :go_down do
      go from: :doors_closing, to: :elevator_going_down
      after do
        puts 'Going Down!'
      end
    end

    event :start do
      go from: [:elevator_going_up, :elevator_going_down], to: :moving
    end

    event :approach do
      go from: :moving, to: :stopping
    end

    event :stop do
      go from: :stopping, to: :doors_opening
      before do
        announce_floor
      end
    end

    event :open_doors do
      go from: :doors_opening, to: :at_floor
    end

    event :finish do
      go from: :at_floor, to: :checking_next_dest
    end

    event :make_request do
      go from: :checking_next_dest, to: :doors_closing
    end

    event :make_no_request do
      go from: :checking_next_dest, to: :idle
    end
  end
  def announce_floor
    puts "Arriving on floor #{rand(10)}"
  end
end

# elevator = Elevator.new
# elevator.prepare
# elevator.go_up
# elevator.start
# elevator.approach
# elevator.stop
# puts elevator.can_open_doors?
# puts elevator.can_finish?