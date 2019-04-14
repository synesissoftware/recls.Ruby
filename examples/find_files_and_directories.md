# recls.Ruby Example - **find_files_and_directories**

## Summary

Illustrates finding of FILES, then DIRECTORIES, then both

## Source

```ruby
#! /usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require 'recls'

puts "files in current directory:"
Recls.file_search(nil, nil, Recls::FILES).each { |fe| puts "\t#{fe.search_relative_path}" }
puts

puts "directories in current directory:"
Recls.file_search(nil, nil, Recls::DIRECTORIES).each { |fe| puts "\t#{fe.search_relative_path}" }
puts

puts "files and directories in current directory:"
Recls.file_search(nil, nil, Recls::DIRECTORIES | Recls::FILES).each { |fe| puts "\t#{fe.search_relative_path}" }
puts
```

## Discussion

The code is pretty self-explanatory, in that there are three searches using
the ```Recls.file_search()``` module method, passing FILES, DIRECTORIES, and
FILES|DIRECTORIES, respectively. For each search, a simple block is
presented, which takes a single-parameter of the file-entry (of type
``Recls::Entry``) from which the ``#search_relative_path`` instance
attribute is used to display the relative path.

## Example results

```
files in current directory:
	build_gem.cmd
	build_gem.sh
	CHANGES.md
	EXAMPLES.md
	generate_rdoc.sh
	LICENSE
	Rakefile
	README.md
	recls.gemspec
	run_all_unit_tests.sh

directories in current directory:
	doc
	examples
	lib
	old-gems
	test

files and directories in current directory:
	build_gem.cmd
	build_gem.sh
	CHANGES.md
	doc
	examples
	EXAMPLES.md
	generate_rdoc.sh
	lib
	LICENSE
	old-gems
	Rakefile
	README.md
	recls.gemspec
	run_all_unit_tests.sh
	test
```

