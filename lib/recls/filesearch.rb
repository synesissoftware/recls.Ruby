# ######################################################################### #
# File:        recls/filesearch.rb
#
# Purpose:     Defines the Recls::FileSearch class for the recls.ruby library.
#
# Created:     24th July 2012
# Updated:     16th February 2014
#
# Author:      Matthew Wilson
#
# Copyright:   <<TBD>>
#
# ######################################################################### #


require File.dirname(__FILE__) + '/entry'
require File.dirname(__FILE__) + '/flags'
require File.dirname(__FILE__) + '/ximpl/os'

module Recls

	class FileSearch

		include Enumerable

		private

		public
		def initialize(dir, patterns, flags)

			@dir		=	dir
			@patterns	=	patterns ? patterns.split(/[#{Ximpl::OS::PATH_SEPARATORS}]/) : []
			@flags		=	flags

		end # def initialize()

		def each(&blk)

			searchDir = @dir.to_s
			searchDir = File::absolute_path searchDir

			FileSearch::search_dir(searchDir, searchDir, @patterns, @flags, &blk)

		end # def each

		private
		def FileSearch::is_dots(name)

			case	name
			when	'.', '..'
				true
			else
				false
			end

		end # is_dots()

		def FileSearch::stat_or_nil_(path)

			begin
				File::Stat::new path
			rescue Errno::ENOENT => x
				nil
			end

		end # stat_or_nil_()

		def FileSearch::search_dir(searchDir, dir, patterns, flags, &blk)

			# matching entries

			entries = []

			#puts patterns

			if patterns.empty?

				pattern = File::join(dir, '*')

				entries = Dir::glob(pattern)

			else

				patterns.each do |pattern|

					pattern = File::join(dir, pattern)

					entries = entries + Dir::glob(pattern)

				end

			end

			entries.each do |entry|

				fs = File::Stat::new(entry)

				blk.call Recls::Entry::new(entry, fs, searchDir)

			end

			# sub-directories

			#puts "subdirs of #{dir}:"

			d = Dir::new(dir)

			d.each do |subdir|

				next if is_dots subdir

				subdirPath = File::join(dir, subdir)

				fs = stat_or_nil_(subdirPath)

				next if not fs
				next if not fs.directory?

				if not fs
				else
					FileSearch::search_dir(searchDir, subdirPath, patterns, flags, &blk)
				end
			end

		end # def each

	end # class FileSearch

end # module Recls
