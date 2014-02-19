# ######################################################################### #
# File:        recls/filesearch.rb
#
# Purpose:     Defines the Recls::FileSearch class for the recls.ruby library.
#
# Created:     24th July 2012
# Updated:     19th February 2014
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

		def initialize(search_root, patterns, flags)

			if not search_root or search_root.empty?
				search_root = '.'
			end

			if(0 == (Recls::TYPEMASK & flags))
				flags |= Recls::FILES
			end

			@search_root	=	search_root
			@patterns	=	patterns ? patterns.split(/[|#{Recls::Ximpl::OS::PATH_SEPARATOR}]/) : []
			@flags		=	flags

		end # def initialize()

		attr_reader :search_root
		attr_reader :patterns
		attr_reader :flags

		def each(&blk)

			search_root = @search_root.to_s
			search_root = Recls::Ximpl::absolute_path search_root

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

			patterns = [ Recls::WILDCARDS_ALL ] if patterns.empty?

			FileSearch::search_directory_(search_root, search_root, patterns, flags, &blk)

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
		# block (blk). The search directory (search_root) is passed in
		# order to allow calculation of search_relative_path in the
		# entry.

		def FileSearch::search_directory_(search_root, dir, patterns, flags, &blk)

			entries = []

			patterns.each do |pattern|

				dir = dir.gsub(/\\/, '/') if Recls::Ximpl::OS::OS_IS_WINDOWS

				pattern = File::join(dir, pattern)

				entries.concat Dir::glob(pattern)
			end

			subdirectories = []

			Dir::new(dir).each do |subdir|

				next if is_dots(subdir)

				subdir_path = File::join(dir, subdir)

				if FileTest::directory?(subdir_path)
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

				blk.call Recls::Entry::new(entry, fs, search_root)
			end

			# sub-directories

			return unless (0 != (Recls::RECURSIVE & flags))

			subdirectories.each do |subdir_path|

				fs = stat_or_nil_(subdir_path)

				next if not fs
				next if not fs.directory?

				FileSearch::search_directory_(search_root, subdir_path, patterns, flags, &blk)
			end

		end # def each

	end # class FileSearch

end # module Recls
