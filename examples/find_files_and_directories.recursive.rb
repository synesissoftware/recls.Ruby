#! /usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require 'recls'

puts "files under current directory:"
Recls.file_rsearch(nil, nil, Recls::FILES).each { |fe| puts "\t#{fe.search_relative_path}" }
puts

puts "directories under current directory:"
Recls.file_rsearch(nil, nil, Recls::DIRECTORIES).each { |fe| puts "\t#{fe.search_relative_path}" }
puts

puts "files and directories under current directory:"
Recls.file_rsearch(nil, nil, Recls::DIRECTORIES | Recls::FILES).each { |fe| puts "\t#{fe.search_relative_path}" }
puts


