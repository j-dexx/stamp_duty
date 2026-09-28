$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require "simplecov"

SimpleCov.start

require 'stamp_duty'

require 'minitest/autorun'
require 'minitest/pride'
