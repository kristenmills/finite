require 'rspec'
require 'simplecov'

SimpleCov.start
require File.join(File.dirname(__FILE__), '..', 'lib', 'finite')
Dir[File.dirname(__FILE__) + "/models/*.rb"].sort.each { |f| require File.expand_path(f) }

RSpec.configure do |config|
  original_stderr = $stderr
  original_stdout = $stdout
  config.before(:all) do
    # Redirect stderr and stdout
    $stderr = StringIO.new
    $stdout = StringIO.new
  end
  config.after(:all) do
    $stderr = original_stderr
    $stdout = original_stdout
  end
end
