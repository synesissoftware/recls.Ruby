#!/usr/bin/ruby
#
# test Recls entry methods

$:.unshift File.join(File.dirname(__FILE__), '../..', 'lib')

require 'recls'

root_dir	=	'.'
patterns	=	Recls::WILDCARDS_ALL

Recls.FileSearch(root_dir, patterns, flags: Recls::FILES).each do |fe|

	drive	=	fe.drive || ''

	puts
	puts "entry:"
	puts fe.path
	puts fe.short_path
	puts fe.directory_path
	puts drive
	puts "".ljust(drive ? drive.size : 0) + fe.directory
	puts "".ljust(fe.directory_path.size) + fe.file
	puts "".ljust(fe.directory_path.size) + "#{fe.file_short_name}"
	puts "".ljust(fe.directory_path.size) + fe.stem
	puts "".ljust(fe.directory_path.size + fe.stem.size) + fe.extension
	n = drive.size
	fe.directory_parts.each do |part|

		puts "".ljust(n) + part
		n += part.size
	end

	puts fe.search_directory
	puts "".ljust(fe.search_directory.size) + fe.search_relative_path
	puts "".ljust(fe.search_directory.size) + fe.search_relative_directory_path
	puts "".ljust(fe.search_directory.size) + fe.search_relative_directory

	n = fe.search_directory.size
	fe.search_relative_directory_parts.each do |part|

		puts "".ljust(n) + part
		n += part.size
	end
end

