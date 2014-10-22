#! /usr/bin/ruby
#
# test Recls canonicalise_path() method

$:.unshift File.join(File.dirname(__FILE__), '../..', 'lib')


#require 'recls/util'
require 'recls/foreach'
#require 'recls'

puts
puts "with given block:"
count_1 = 0
Recls.foreach(Recls::FileSearch.new(nil, '*.rb', Recls::RECURSIVE)).each do |fe, line_number, line|

	line		=	line.chomp
	line_number	=	1 + line_number

	puts "#{fe.search_relative_path}(#{line_number + 1}): #{line}"

	count_1 += 1
	break if 20 == count_1
end

puts
puts "as returned enumerator:"
e = Recls.foreach(Recls::FileSearch.new(nil, '*.rb', Recls::RECURSIVE))
count_2 = 0
e.each do |fe, line_number, line|

	line		=	line.chomp
	line_number	=	1 + line_number

	puts "#{fe.search_relative_path}(#{line_number + 1}): #{line}"

	count_2 += 1
	break if 20 == count_2
end


