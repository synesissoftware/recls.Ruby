# ######################################################################### #
# File:        recls/entry.rb
#
# Purpose:     Defines the Recls::Entry class for the recls.ruby library.
#
# Created:     24th July 2012
# Updated:     16th February 2014
#
# Author:      Matthew Wilson
#
# Copyright:   <<TBD>>
#
# ######################################################################### #


require File.dirname(__FILE__) + '/flags'
require File.dirname(__FILE__) + '/ximpl/util'

module Recls

	class Entry

		# initialises an entry instance from the given path,
		# file_stat, and search_dir
		def initialize(path, file_stat, search_dir)

			@file_stat = file_stat

			@path = Recls::Ximpl::absolute_path path
			@directory_path = File::dirname @path
			@directory = Recls::Ximpl::directory_from_directory_path @directory_path
			@directory_parts = Recls::Ximpl::directory_parts_from_directory directory

			@file_basename = Recls::Ximpl::basename @path
			@file_ext = Recls::Ximpl::file_ext @file_basename

			@search_directory = search_dir
			@search_relative_path = Recls::Ximpl::search_relative_path @path, search_dir

		end # def initialize

		attr_reader :path
		attr_reader :directory_path
		attr_reader :directory
		attr_reader :directory_parts
		attr_reader :file_basename
		alias_method :file, :file_basename
		alias_method :file_name, :file_basename
		attr_reader :file_ext
		attr_reader :search_directory
		attr_reader :search_relative_path

		# indicates whether the given entry represents a directory
		def directory?

			@file_stat.directory?

		end # directory?

		# indicates whether the given entry represents a file
		def file?

			@file_stat.file?

		end # file?

		# indicates whether the given entry is readonly
		def readonly?

			not @file_stat.writable?

		end # readonly?

		# indicates whether the given entry represents a socket
		def socket?

			@file_stat.socket?

		end # socket?

		# indicates the size of the given entry
		def size

			@file_stat.size

		end # size

		# indicates the last access time of the entry
		def last_access_time

			@file_stat.atime

		end # last_access_time

		# indicates the modification time of the entry
		def modification_time

			@file_stat.mtime

		end # modification_time

		# represents the entry as a string (in the form of
		# the full path)
		def to_s

			path

		end # def to_s

		# represents the entry as a string (in the form of
		# the full path)
		def to_str

			path

		end # def to_s

	end # class Entry

end # module Recls

