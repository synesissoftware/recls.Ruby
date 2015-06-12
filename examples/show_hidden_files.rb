
$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require 'recls'

# To find only hidden files, need to:
#
# 1. Ensure that they are returned in search, by including Recls::SHOW_HIDDEN
# 2. Filter returned entries by hidden? attribute
Recls::FileSearch.new('.', Recls::WILDCARDS_ALL, Recls::FILES | Recls::RECURSIVE | Recls::SHOW_HIDDEN).each do |fe|

	puts fe.path if fe.hidden?

end

