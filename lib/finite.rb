[
  'version',
  'transition',
  'event',
  'state',
  'machine',
  'class_methods'
].each { |file| require File.join(File.dirname(__FILE__), 'finite', file) }

# The Finite module. The module that contains all the classes and methods for
# the finite gem.
module Finite

  # Override included method
  def self.included(base)
    base.extend(ClassMethods)
    super
  end
end