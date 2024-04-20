#! /usr/bin/ruby
#
# test Search between files and directories

$:.unshift File.join(File.dirname(__FILE__), '../..', 'lib')

require 'recls'

puts
puts "adding own trailing slash:"
puts

Recls::FileSearch.new(nil, nil, Recls::FILES | Recls::DIRECTORIES | Recls::RECURSIVE).each do |fe|

  path = fe.search_relative_path

  if fe.directory?

    puts path + '/'
  else

    puts path
  end
end

puts
puts "specifying flag for trailing slash:"
puts

Recls::FileSearch.new(nil, nil, Recls::FILES | Recls::DIRECTORIES | Recls::RECURSIVE | Recls::MARK_DIRECTORIES).each do |fe|

  path = fe.search_relative_path

  puts path
end

