#! /usr/bin/env ruby
#
# test Recls entry methods showing parts

$:.unshift File.join(File.dirname(__FILE__), '../..', 'lib')

require 'recls'

root_dir    = File.join(File.dirname(__FILE__), '../..')
patterns_a  = %w{ *.rb *.md }
patterns_s  = patterns_a.join('|')


puts
puts "Searching for pattern string '#{patterns_s}':"

Recls::FileSearch.new(root_dir, patterns_s, Recls::FILES | Recls::RECURSIVE).each do |fe|

  puts fe.search_relative_path
end



puts
puts "Searching for pattern array '#{patterns_a}':"

Recls::FileSearch.new(root_dir, patterns_a, Recls::FILES | Recls::RECURSIVE).each do |fe|

  puts fe.search_relative_path
end


