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

		def initialize(dir, patterns, flags)

			if(0 == (Recls::TYPEMASK & flags))
				flags |= Recls::FILES
			end

			@dir		=	dir
			@patterns	=	patterns ? patterns.split(/[#{Recls::Ximpl::OS::PATH_SEPARATORS}]/) : []
			@flags		=	flags

		end # def initialize()

		def each(&blk)

			search_dir = @dir.to_s
			search_dir = Recls::Ximpl::absolute_path search_dir

			# set the (type part of the) flags to zero if we want
			# everything, to facilitate later optimisation

			flags = @flags

			if(Recls::Ximpl::OS::OS_IS_WINDOWS)
				mask = (Recls::FILES | Recls::DIRECTORIES)
			else
				mask = (Recls::FILES | Recls::DIRECTORIES | Recls::LINKS | Recls::DEVICES)
			end

			if(mask == (mask & flags))
				flags = flags & ~Recls::TYPEMASK
			end

			patterns = @patterns

			patterns = [ Recls::wildcards_all ] if patterns.empty?

			FileSearch::search_dir_(search_dir, search_dir, patterns, flags, &blk)

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

		# searches all entries - files, directories, links, devices
		# - that match the given (patterns) in the given directory
		# (dir) according to the given (flags), invoking the given
		# block (blk). The search directory (search_dir) is passed in
		# order to allow calculation of search_relative_path in the
		# entry.

		def FileSearch::search_dir_(search_dir, dir, patterns, flags, &blk)

			entries = []

			patterns.each do |pattern|

				dir = dir.gsub(/\\/, '/') if Recls::Ximpl::OS::OS_IS_WINDOWS

				pattern = File::join(dir, pattern)

				entries.concat Dir::glob(pattern)
			end

			subdirectories = []

			Dir::new(dir).each do |subdir|

				subdir_path = File::join(dir, subdir)

				if(FileTest::directory?(subdir_path) and not is_dots(subdir))
					subdirectories << subdir_path
				end
			end

			entries.concat subdirectories

			entries.each do |entry|

				fs = File::Stat::new(entry)

				if(0 == (Recls::TYPEMASK & flags))
				elsif ((0 != (Recls::FILES & flags)) && !fs.file?)
					next
				elsif ((0 != (Recls::DIRECTORIES & flags)) && !fs.directory?)
					next
				elsif ((0 != (Recls::LINKS & flags)) && !fs.symlink?)
					next
				elsif ((0 != (Recls::DEVICES & flags)) && !fs.blockdev?)
					next
				end

				blk.call Recls::Entry::new(entry, fs, search_dir)
			end

			# sub-directories

			return unless (0 != (Recls::RECURSIVE & flags))

			subdirectories.each do |subdir_path|

				fs = stat_or_nil_(subdir_path)

				next if not fs
				next if not fs.directory?

				FileSearch::search_dir_(search_dir, subdir_path, patterns, flags, &blk)
			end

		end # def each

	end # class FileSearch

end # module Recls
