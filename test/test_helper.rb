gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

lib = File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift lib unless $LOAD_PATH.include? lib
