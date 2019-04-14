#! /usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require 'recls'

puts "files in current directory:"
Recls.file_search(nil, nil, Recls::FILES).each { |fe| puts "\t#{fe.search_relative_path}" }
puts

puts "directories in current directory:"
Recls.file_search(nil, nil, Recls::DIRECTORIES).each { |fe| puts "\t#{fe.search_relative_path}" }
puts

puts "files and directories in current directory:"
Recls.file_search(nil, nil, Recls::DIRECTORIES | Recls::FILES).each { |fe| puts "\t#{fe.search_relative_path}" }
puts


