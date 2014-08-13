#!/usr/bin/env ruby

file      = File.realdirpath(__FILE__)
directory = File.dirname(file)

$:.unshift(directory + '/lib')

system 'clear'

require 'cli'

CLI.new.run
