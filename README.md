# Finite

A simple state machine implementation for ruby

## Installation

Add this line to your application's Gemfile:

    gem 'finite'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install finite

## Usage
```ruby

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
```

```ruby
elevator = Elevator.new
elevator.current_state          # => :idle
elevator.can_prepare?           # => true
elevator.can_open_doors?        # => false
elevator.open_doors             # => RuntimeError 'Invalid Transition'
elevator.idle?                  # => true
elevator.prepare
elevator.current_state          # => :doors_closing
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License
Copyright (c) 2013 Kristen Mills

MIT License

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.