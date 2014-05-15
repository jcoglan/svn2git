$:.unshift "#{File.dirname(__FILE__)}/../lib"

require 'rubygems'
require 'svn2git'
require 'minitest/autorun'

if Minitest.const_defined?('Test')
  # We're on Minitest 5+. Nothing to do here.
else
  # Minitest 4 doesn't have Minitest::Test yet.
  Minitest::Test = MiniTest::Unit::TestCase
end