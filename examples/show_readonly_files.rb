#! /usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require 'recls'

# To find only readonly files, need to:
#
# 1. Filter returned entries by readonly? attribute
Recls.file_rsearch('.', Recls::WILDCARDS_ALL, Recls::FILES).each do |fe|

  puts fe.path if fe.readonly?
end

