#! /usr/bin/env ruby
#
# executes all other tests

this_dir = File.expand_path(File.dirname(__FILE__))

# all tc_*rb in current directory
Dir[File.join(this_dir, 'tc_*rb')].each do |file|

  $stderr.puts "requiring file '#{file}'" if $DEBUG

  require file
end

# all ts_*rb in immediate sub-directories
Dir[File.join(this_dir, '*', 'ts_*rb')].each do |file|

  $stderr.puts "requiring file '#{file}'" if $DEBUG

  require file
end

