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

	class Elevator
		include Finite
		
		finite do
			state :idle, start: true do 
				on event: :prepare_up, change_to: :move_up
				on event: :prepare_down, change_to: :move_down
			end
			state :move_up do 
				on event: :door_closed, change_to: :elevator_up
			end
			state :elevator_up do
				on event: :started, change_to: :moving
			end
			state :move_down do
				on event: :door_closed, change_to: :elevator_down
			end
			state :elevator_down do
				on event: :started, change_to: :moving
			end
			state :moving do 
				on event: :approaching, change_to: :stopping
			end
			state :stopping do
				on event: :stopped, change_to: :door_opening
			end
			state :door_opening do
				on event: :door_opened, change_to: :at_floor
			end
			state :at_floor do
				on event: :done, change_to: :check_next_dest
			end
			state :check_next_dest do
				on event: :up_request, change_to: :move_up
				on event: :down_request, change_to: :move_down
				on event: :no_request, change_to: :idle
			end
		end
	end

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