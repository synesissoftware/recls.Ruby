#! /usr/bin/ruby
#
# Demonstrates search of hidden files

$:.unshift File.join(File.dirname(__FILE__), '../..', 'lib')

require 'recls'

puts
puts "Hidden directories:"
Recls.file_rsearch(nil, nil, Recls::DIRECTORIES | Recls::SHOW_HIDDEN).each do |fe|

  puts "\t#{fe.search_relative_path}" if fe.hidden?
end

puts
puts "Hidden files:"
Recls.file_search(nil, nil, Recls::RECURSIVE | Recls::FILES | Recls::SHOW_HIDDEN).each do |fe|

  puts "\t#{fe.search_relative_path}" if fe.hidden?
end


puts
puts "Hidden directories & files:"
Recls.file_search(nil, nil, Recls::RECURSIVE | Recls::DIRECTORIES | Recls::FILES | Recls::MARK_DIRECTORIES | Recls::SHOW_HIDDEN).each do |fe|

  puts "\t#{fe.search_relative_path}" if fe.hidden?
end

