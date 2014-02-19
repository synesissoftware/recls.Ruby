
require 'recls'

puts
puts "Hidden directories:"
Recls::FileSearch::new(nil, nil, Recls::RECURSIVE | Recls::DIRECTORIES).each do |fe|

	puts "\t#{fe.searchRelativePath}" if fe.hidden?
end

puts
puts "Hidden files:"
Recls::FileSearch::new(nil, nil, Recls::RECURSIVE).each do |fe|

	puts "\t#{fe.searchRelativePath}" if fe.hidden?
end

