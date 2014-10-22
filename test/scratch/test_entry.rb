
require 'recls'

puts "PATH_NAME_SEPARATOR:\t[#{Recls::PATH_NAME_SEPARATOR}]"
puts "PATH_SEPARATOR:\t[#{Recls::PATH_SEPARATOR}]"
puts "WILDCARDS_ALL:\t[#{Recls::WILDCARDS_ALL}]"

f = Recls::stat('.')

puts "entry:"
puts "\t#{'(entry)'.ljust(20)}\t#{f}"
puts "\t#{'f.path'.ljust(20)}\t#{f.path}"
puts "\t#{'f.drive'.ljust(20)}\t#{f.drive}"
puts "\t#{'f.directory_path'.ljust(20)}\t#{f.directory_path}"
puts "\t#{'f.directory'.ljust(20)}\t#{f.directory}"
directory_parts = f.directory_parts
puts "\t#{'f.directory_parts'.ljust(20)}\t[#{directory_parts.size}]"
directory_parts.each do |part|
	puts "\t#{''.ljust(20)}\t\t#{part}"
end
puts "\t#{'f.file_full_name'.ljust(20)}\t#{f.file_full_name}"
puts "\t#{'f.file_short_name'.ljust(20)}\t#{f.file_short_name}"
puts "\t#{'f.file_name_only'.ljust(20)}\t#{f.file_name_only}"
puts "\t#{'f.file_extension'.ljust(20)}\t#{f.file_extension}"
puts "\t#{'f.search_directory'.ljust(20)}\t#{f.search_directory}"
puts "\t#{'f.search_relative_path'.ljust(20)}\t#{f.search_relative_path}"

puts "\t#{'f.size'.ljust(20)}\t#{f.size}"

puts "\t#{'f.exist?'.ljust(20)}\t#{f.exist?}"
puts "\t#{'f.hidden?'.ljust(20)}\t#{f.hidden?}"
puts "\t#{'f.readonly?'.ljust(20)}\t#{f.readonly?}"
puts "\t#{'f.directory?'.ljust(20)}\t#{f.directory?}"
puts "\t#{'f.file?'.ljust(20)}\t#{f.file?}"
puts "\t#{'f.socket?'.ljust(20)}\t#{f.socket?}"

puts "\t#{'f.modification_time'.ljust(20)}\t#{f.modification_time}"
puts "\t#{'f.last_access_time'.ljust(20)}\t#{f.last_access_time}"

puts
puts "directories:"
num_directories = 0
Recls::FileSearch::new('.', '*', Recls::DIRECTORIES).each do |fe|

	num_directories += 1
	puts "\t[#{fe.search_relative_path}]"
end
puts "  #{num_directories} directories"

puts
puts "files:"
num_files = 0
Recls::FileSearch::new('.', '*.rb', Recls::RECURSIVE | Recls::FILES).each do |fe|

	num_files += 1
	puts "\t<#{fe.search_relative_path}>"
end
puts "  #{num_files} file(s)"
