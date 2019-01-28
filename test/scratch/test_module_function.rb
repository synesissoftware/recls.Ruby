#! /usr/bin/ruby
#
# test Recls entry methods showing parts, via module function

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
	puts "".ljust(drive ? drive.size : 0) + fe.directory.to_s
	puts "".ljust(fe.directory_path.size) + fe.file.to_s
	puts "".ljust(fe.directory_path.size) + fe.file_short_name.to_s
	puts "".ljust(fe.directory_path.size) + fe.stem.to_s
	puts "".ljust(fe.directory_path.size + fe.stem.size) + fe.extension.to_s
	n = drive.size
	fe.directory_parts.each do |part|

		puts "".ljust(n) + part
		n += part.size
	end

	puts fe.search_directory
	puts "".ljust(fe.search_directory.size) + fe.search_relative_path.to_s
	puts "".ljust(fe.search_directory.size) + fe.search_relative_directory_path.to_s
	puts "".ljust(fe.search_directory.size) + fe.search_relative_directory.to_s

	n = fe.search_directory.size
	fe.search_relative_directory_parts.each do |part|

		puts "".ljust(n) + part
		n += part.size
	end
end

