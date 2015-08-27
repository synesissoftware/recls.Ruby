#! /usr/bin/ruby
#
# Demonstrates search of hidden files

$:.unshift File.join(File.dirname(__FILE__), '../..', 'lib')

require 'recls'

puts
puts "Hidden directories:"
Recls::FileSearch.new(nil, nil, Recls::RECURSIVE | Recls::DIRECTORIES | Recls::SHOW_HIDDEN).each do |fe|

	puts "\t#{fe.searchRelativePath}" if fe.hidden?
end

puts
puts "Hidden files:"
Recls::FileSearch.new(nil, nil, Recls::RECURSIVE | Recls::FILES | Recls::SHOW_HIDDEN).each do |fe|

	puts "\t#{fe.searchRelativePath}" if fe.hidden?
end


puts
puts "Hidden directories & files:"
Recls::FileSearch.new(nil, nil, Recls::RECURSIVE | Recls::DIRECTORIES | Recls::FILES | Recls::MARK_DIRECTORIES | Recls::SHOW_HIDDEN).each do |fe|

	puts "\t#{fe.searchRelativePath}" if fe.hidden?
end

