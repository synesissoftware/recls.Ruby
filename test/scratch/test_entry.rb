
require 'recls'

puts "wildcardsAll:\t[#{Recls::wildcardsAll}]"

f = Recls::stat('.')

puts "entry:"
puts "\t(entry)\t#{f}"
puts "\tf.path\t#{f.path}"
puts "\tf.directoryPath\t#{f.directoryPath}"
puts "\tf.directory\t#{f.directory}"
puts "\tf.file\t#{f.file}"
puts "\tf.fileBasename\t#{f.fileBasename}"
puts "\tf.fileName\t#{f.fileName}"
puts "\tf.fileName\t#{f.fileName}"
puts "\tf.fileExt\t#{f.fileExt}"
puts "\tf.size\t#{f.size}"
puts "\tf.directory?\t#{f.directory?}"
puts "\tf.file?\t#{f.file?}"
puts "\tf.socket?\t#{f.socket?}"
directoryParts = f.directoryParts
puts "\tf.directoryParts [#{directoryParts.size}]"
directoryParts.each do |part|
	puts "\t\t#{part}"
end
puts "\tf.modificationTime\t#{f.modificationTime}"
puts "\tf.lastAccessTime\t#{f.lastAccessTime}"

puts
puts "directories:"
numDirectories = 0
Recls::FileSearch::new('.', '*.rb', Recls::DIRECTORIES).each do |fe|

	numDirectories += 1
	puts "[#{fe.searchRelativePath}]"
end
puts "  #{numDirectories} directories"

puts
puts "files:"
numFiles = 0
Recls::FileSearch::new('.', '*.rb', Recls::FILES).each do |fe|

	numFiles += 1
	puts "<#{fe.searchRelativePath}>"
end
puts "  #{numFiles} file(s)"
