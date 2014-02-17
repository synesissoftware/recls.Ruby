
require 'recls'

puts "wildcards_all:\t[#{Recls::wildcards_all}]"

f = Recls::stat('.')

puts "entry:"
puts "\t(entry)\t#{f}"
puts "\tf.path\t#{f.path}"
puts "\tf.directory_path\t#{f.directory_path}"
puts "\tf.directory\t#{f.directory}"
puts "\tf.file\t#{f.file}"
puts "\tf.file_basename\t#{f.file_basename}"
puts "\tf.file_name\t#{f.file_name}"
puts "\tf.file_name\t#{f.file_name}"
puts "\tf.file_ext\t#{f.file_ext}"
puts "\tf.size\t#{f.size}"
puts "\tf.directory?\t#{f.directory?}"
puts "\tf.file?\t#{f.file?}"
puts "\tf.socket?\t#{f.socket?}"
directory_parts = f.directory_parts
puts "\tf.directory_parts [#{directory_parts.size}]"
directory_parts.each do |part|
	puts "\t\t#{part}"
end
puts "\tf.modification_time\t#{f.modification_time}"
puts "\tf.last_access_time\t#{f.last_access_time}"

puts
puts "directories:"
num_directories = 0
Recls::FileSearch::new('.', '*.rb', Recls::DIRECTORIES).each do |fe|

	num_directories += 1
	puts "[#{fe.search_relative_path}]"
end
puts "  #{num_directories} directories"

puts
puts "files:"
num_files = 0
Recls::FileSearch::new('.', '*.rb', Recls::RECURSIVE | Recls::FILES).each do |fe|

	num_files += 1
	puts "<#{fe.search_relative_path}>"
end
puts "  #{num_files} file(s)"
