#!/usr/bin/ruby
#
# Demonstrates use of dev and ino attributes

$:.unshift File.join(File.dirname(__FILE__), '../..', 'lib')

require 'recls'

Recls::FileSearch.new('.', Recls::WILDCARDS_ALL, Recls::FILES | Recls::RECURSIVE).each do |fe|

	puts "#{fe.search_relative_path}\t#{fe.dev}\t#{fe.ino}"
end

