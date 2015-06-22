# gemspec for recls

Gem::Specification.new do |gs|

	gs.name			=	'recls'
	gs.version		=	'2.1.1'
	gs.date			=	'2015-06-22'
	gs.summary		=	'recls.Ruby'
	gs.description	=	'recsl Ruby library'
	gs.authors		=	[ 'Matt Wilson' ]
	gs.email		=	'matthew@recls.org'
	gs.files		=	[
							'examples/show_hidden_files.rb',
							'examples/show_readonly_files.rb',
							'lib/recls.rb',
							'lib/recls/entry.rb',
							'lib/recls/filesearch.rb',
							'lib/recls/flags.rb',
							'lib/recls/foreach.rb',
							'lib/recls/recls.rb',
							'lib/recls/stat.rb',
							'lib/recls/util.rb',
							'lib/recls/internal/common.rb',
							'lib/recls/internal/version.rb',
							'lib/recls/ximpl/os.rb',
							'lib/recls/ximpl/unix.rb',
							'lib/recls/ximpl/util.rb',
							'lib/recls/ximpl/windows.rb',
							'test/test_recls.rb',
							'test/scratch/test_entry.rb',
							'test/scratch/test_foreach.rb',
							'test/scratch/test_show_hidden.rb',
							'test/unit/tc_recls_entries.rb',
							'test/unit/tc_recls_entry.rb',
							'test/unit/tc_recls_file_search.rb',
							'test/unit/tc_recls_module.rb',
							'test/unit/tc_recls_util.rb',
							'test/unit/tc_recls_ximpl_util.rb',
							'test/unit/ts_all.rb',
	]
	gs.homepage		=	'http://recls.org/'
	gs.license		=	'Modified BSD'
end

