
class Elevator
  include Finite

  finite initial: :idle do

    before :doors_closing do
      puts 'Doors Closing!'
    end

    before :doors_opening do
      puts 'Doors Opening!'
    end

    event :prepare do
      go from: :idle, to: :doors_closing
    end

    event :go_up do
      go from: :doors_closing, to: :elevator_up
      after do
        puts 'Going Up!'
      end
    end

    event :go_down do
      go from: :doors_closing, to: :elevator_down
      after do
        puts 'Going Down!'
      end
    end

    event :started do
      go from: [:elevator_up, :elevator_down], to: :moving
    end

    event :approaching do
      go from: :moving, to: :stopping
    end

    event :stopped do
      go from: :stopping, to: :doors_opening
      before do
        announce_floor
      end
    end

    event :door_opened do
      go from: :doors_opening, to: :at_floor
    end

    event :done do
      go from: :at_floor, to: :check_next_dest
    end

    event :request do
      go from: :check_next_dest, to: :door_closing
    end

    event :no_request do
      go from: :check_next_dest, to: :idle
    end
  end
  def announce_floor
    puts "Arriving on floor #{rand(10)}"
  end
end
