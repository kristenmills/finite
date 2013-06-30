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
require 'finite'

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
			go from: :idle, to: :door_closing
		end

		event :go_up do
			go from: :door_closing, to: :elevator_up
			after do
				puts 'Going Up!'
			end
		end

		event :go_down do
			go from: :door_closing, to: :elevator_down
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
			go from: :stopping, to: :door_opening
			before do
				announce_floor
			end
		end

		event :door_opened do
			go from: :door_opening, to: :at_floor
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
		puts 'Now arriving on floor #{@floor}'
	end
end
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