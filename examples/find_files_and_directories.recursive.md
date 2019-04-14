# recls.Ruby Example - **find_files_and_directories.recursive**

## Summary

Illustrates recursive finding of FILES, then DIRECTORIES, then both

## Source

```ruby
#! /usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require 'recls'

puts "files under current directory:"
Recls.file_rsearch(nil, nil, Recls::FILES).each { |fe| puts "\t#{fe.search_relative_path}" }
puts

puts "directories under current directory:"
Recls.file_rsearch(nil, nil, Recls::DIRECTORIES).each { |fe| puts "\t#{fe.search_relative_path}" }
puts

puts "files and directories under current directory:"
Recls.file_rsearch(nil, nil, Recls::DIRECTORIES | Recls::FILES).each { |fe| puts "\t#{fe.search_relative_path}" }
puts
```

## Discussion

The code is pretty self-explanatory, in that there are three searches using
the ```Recls.file_rsearch()``` module method, passing FILES, DIRECTORIES, and
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
	doc/CHANGES_md.html
	doc/created.rid
	doc/EXAMPLES_md.html
	doc/index.html
	doc/LICENSE.html
	doc/README_md.html
	doc/Recls.html
	doc/table_of_contents.html
	doc/css/fonts.css
	doc/css/rdoc.css
	doc/examples/show_hidden_files_md.html
	doc/examples/show_readonly_files_md.html
	doc/fonts/Lato-Light.ttf
	doc/fonts/Lato-LightItalic.ttf
	doc/fonts/Lato-Regular.ttf
	doc/fonts/Lato-RegularItalic.ttf
	doc/fonts/SourceCodePro-Bold.ttf
	doc/fonts/SourceCodePro-Regular.ttf
	doc/images/add.png
	doc/images/arrow_up.png
	doc/images/brick.png
	doc/images/brick_link.png
	doc/images/bug.png
	doc/images/bullet_black.png
	doc/images/bullet_toggle_minus.png
	doc/images/bullet_toggle_plus.png
	doc/images/date.png
	doc/images/delete.png
	doc/images/find.png
	doc/images/loadingAnimation.gif
	doc/images/macFFBgHack.png
	doc/images/package.png
	doc/images/page_green.png
	doc/images/page_white_text.png
	doc/images/page_white_width.png
	doc/images/plugin.png
	doc/images/ruby.png
	doc/images/tag_blue.png
	doc/images/tag_green.png
	doc/images/transparent.png
	doc/images/wrench.png
	doc/images/wrench_orange.png
	doc/images/zoom.png
	doc/js/darkfish.js
	doc/js/jquery.js
	doc/js/navigation.js
	doc/js/navigation.js.gz
	doc/js/search.js
	doc/js/search_index.js
	doc/js/search_index.js.gz
	doc/js/searcher.js
	doc/js/searcher.js.gz
	doc/Recls/Entry.html
	examples/find_files_and_directories.md
	examples/find_files_and_directories.rb
	examples/find_files_and_directories.recursive.
	examples/find_files_and_directories.recursive.md
	examples/find_files_and_directories.recursive.rb
	examples/show_hidden_files.md
	examples/show_hidden_files.rb
	examples/show_readonly_files.md
	examples/show_readonly_files.rb
	lib/recls.rb
	lib/recls/api.rb
	lib/recls/combine_paths_1.rb
	lib/recls/combine_paths_2plus.rb
	lib/recls/entry.rb
	lib/recls/file_search.rb
	lib/recls/flags.rb
	lib/recls/foreach.rb
	lib/recls/obsolete.rb
	lib/recls/recls.rb
	lib/recls/stat.rb
	lib/recls/util.rb
	lib/recls/version.rb
	lib/recls/ximpl/os.rb
	lib/recls/ximpl/unix.rb
	lib/recls/ximpl/util.rb
	lib/recls/ximpl/windows.rb
	old-gems/recls-2.6.3.gem
	old-gems/recls-ruby-2.10.0.gem
	test/scratch/test_display_parts.rb
	test/scratch/test_entry.rb
	test/scratch/test_files_and_directories.rb
	test/scratch/test_foreach.rb
	test/scratch/test_module_function.rb
	test/scratch/test_show_dev_and_ino.rb
	test/scratch/test_show_hidden.rb
	test/unit/tc_recls_entries.rb
	test/unit/tc_recls_entry.rb
	test/unit/tc_recls_file_search.rb
	test/unit/tc_recls_module.rb
	test/unit/tc_recls_util.rb
	test/unit/tc_recls_ximpl_util.rb
	test/unit/test_all_separately.cmd
	test/unit/test_all_separately.sh
	test/unit/ts_all.rb

directories in current directory:
	doc
	examples
	lib
	old-gems
	test
	doc/css
	doc/examples
	doc/fonts
	doc/images
	doc/js
	doc/Recls
	lib/recls
	lib/recls/ximpl
	test/scratch
	test/unit

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
	doc/CHANGES_md.html
	doc/created.rid
	doc/css
	doc/examples
	doc/EXAMPLES_md.html
	doc/fonts
	doc/images
	doc/index.html
	doc/js
	doc/LICENSE.html
	doc/README_md.html
	doc/Recls
	doc/Recls.html
	doc/table_of_contents.html
	doc/css/fonts.css
	doc/css/rdoc.css
	doc/examples/show_hidden_files_md.html
	doc/examples/show_readonly_files_md.html
	doc/fonts/Lato-Light.ttf
	doc/fonts/Lato-LightItalic.ttf
	doc/fonts/Lato-Regular.ttf
	doc/fonts/Lato-RegularItalic.ttf
	doc/fonts/SourceCodePro-Bold.ttf
	doc/fonts/SourceCodePro-Regular.ttf
	doc/images/add.png
	doc/images/arrow_up.png
	doc/images/brick.png
	doc/images/brick_link.png
	doc/images/bug.png
	doc/images/bullet_black.png
	doc/images/bullet_toggle_minus.png
	doc/images/bullet_toggle_plus.png
	doc/images/date.png
	doc/images/delete.png
	doc/images/find.png
	doc/images/loadingAnimation.gif
	doc/images/macFFBgHack.png
	doc/images/package.png
	doc/images/page_green.png
	doc/images/page_white_text.png
	doc/images/page_white_width.png
	doc/images/plugin.png
	doc/images/ruby.png
	doc/images/tag_blue.png
	doc/images/tag_green.png
	doc/images/transparent.png
	doc/images/wrench.png
	doc/images/wrench_orange.png
	doc/images/zoom.png
	doc/js/darkfish.js
	doc/js/jquery.js
	doc/js/navigation.js
	doc/js/navigation.js.gz
	doc/js/search.js
	doc/js/search_index.js
	doc/js/search_index.js.gz
	doc/js/searcher.js
	doc/js/searcher.js.gz
	doc/Recls/Entry.html
	examples/find_files_and_directories.md
	examples/find_files_and_directories.rb
	examples/find_files_and_directories.recursive.
	examples/find_files_and_directories.recursive.md
	examples/find_files_and_directories.recursive.rb
	examples/show_hidden_files.md
	examples/show_hidden_files.rb
	examples/show_readonly_files.md
	examples/show_readonly_files.rb
	lib/recls
	lib/recls.rb
	lib/recls/api.rb
	lib/recls/combine_paths_1.rb
	lib/recls/combine_paths_2plus.rb
	lib/recls/entry.rb
	lib/recls/file_search.rb
	lib/recls/flags.rb
	lib/recls/foreach.rb
	lib/recls/obsolete.rb
	lib/recls/recls.rb
	lib/recls/stat.rb
	lib/recls/util.rb
	lib/recls/version.rb
	lib/recls/ximpl
	lib/recls/ximpl/os.rb
	lib/recls/ximpl/unix.rb
	lib/recls/ximpl/util.rb
	lib/recls/ximpl/windows.rb
	old-gems/recls-2.6.3.gem
	old-gems/recls-ruby-2.10.0.gem
	test/scratch
	test/unit
	test/scratch/test_display_parts.rb
	test/scratch/test_entry.rb
	test/scratch/test_files_and_directories.rb
	test/scratch/test_foreach.rb
	test/scratch/test_module_function.rb
	test/scratch/test_show_dev_and_ino.rb
	test/scratch/test_show_hidden.rb
	test/unit/tc_recls_entries.rb
	test/unit/tc_recls_entry.rb
	test/unit/tc_recls_file_search.rb
	test/unit/tc_recls_module.rb
	test/unit/tc_recls_util.rb
	test/unit/tc_recls_ximpl_util.rb
	test/unit/test_all_separately.cmd
	test/unit/test_all_separately.sh
	test/unit/ts_all.rb
```


