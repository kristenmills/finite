require 'rspec'
require 'simplecov'

SimpleCov.start
require File.join(File.dirname(__FILE__), '..', 'lib', 'finite')
Dir[File.dirname(__FILE__) + "/models/*.rb"].sort.each { |f| require File.expand_path(f) }