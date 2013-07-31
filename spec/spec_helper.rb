require 'rspec'
require 'simplecov'

SimpleCov.start
require File.join(__dir__, '..', 'lib', 'finite')
Dir[__dir__ + "/models/*.rb"].sort.each { |f| require File.expand_path(f) }

RSpec.configure do |config|
  original_stderr = $stderr
  original_stdout = $stdout
  config.before(:all) do
    # Redirect stderr and stdout
    $stderr = File.new(File.join(__dir__, 'null.txt'), 'w')
    $stdout = File.new(File.join(__dir__, 'null.txt'), 'w')
  end
  config.after(:all) do
    $stderr = original_stderr
    $stdout = original_stdout
  end
end