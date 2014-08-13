file      = File.realdirpath(__FILE__)
directory = File.dirname(file)

$:.unshift(directory + '/lib')

system 'clear'

require 'glens_cli'

CLI.new.start
