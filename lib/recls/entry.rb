# ######################################################################### #
# File:        recls/entry.rb
#
# Purpose:     Defines the Recls::Entry class for the recls.ruby library.
#
# Created:     24th July 2012
# Updated:     13th October 2014
#
# Author:      Matthew Wilson
#
# Copyright:   <<TBD>>
#
# ######################################################################### #


require File.join(File.dirname(__FILE__), 'internal/common')
require File.join(File.dirname(__FILE__), 'internal/version')
require File.join(File.dirname(__FILE__), 'ximpl/os')
require File.join(File.dirname(__FILE__), 'ximpl', (Recls::Ximpl::OS::OS_IS_WINDOWS ? 'windows.rb' : 'unix.rb'))
require File.join(File.dirname(__FILE__), 'ximpl/util')

module Recls

	class Entry

		# initialises an entry instance from the given path,
		# file_stat, and search_dir
		def initialize(path, file_stat, search_dir)

			@file_stat = file_stat

			@path = Recls::Ximpl::absolute_path path

			windows_drive, directory, basename, file_name, file_ext = Recls::Ximpl::Util.split_path @path

			@drive = windows_drive
			@directory_path = "#{windows_drive}#{directory}"
			@directory = directory ? directory : ''
			@directory_parts = Recls::Ximpl::directory_parts_from_directory directory
			@file_full_name = basename ? basename : ''
			@file_short_name = nil
			@file_name_only = file_name ? file_name : ''
			@file_extension = file_ext ? file_ext : ''

			@search_directory = search_dir
			@search_relative_path = Recls::Ximpl::derive_relative_path @path, search_dir

		end # def initialize

		# ##########################
		# Name-related attributes

		attr_reader :path
		attr_reader :drive
		attr_reader :directory_path
		alias_method :dirname, :directory_path
		attr_reader :directory
		attr_reader :directory_parts
		attr_reader :file_full_name
		attr_reader :file_short_name
		alias_method :basename, :file_full_name
		attr_reader :file_name_only
		attr_reader :file_extension
		alias_method :extension, :file_extension
		attr_reader :search_directory
		attr_reader :search_relative_path

		# ##########################
		# Nature attributes

		# indicates whether the given entry exists
		def exist?

			true

		end # def exist?

		# indicates whether the given entry is hidden
		def hidden?

			@file_stat.hidden?

		end # def hidden?

		# indicates whether the given entry is readonly
		def readonly?

			not @file_stat.writable?

		end # readonly?

		# ##########################
		# Comparison

	if Recls::Ximpl::OS::OS_IS_WINDOWS

		def system?

			@file_stat.system?

		end # system?

		def archive?

			@file_stat.archive?

		end # archive?

		def device?

			@file_stat.device?

		end # device?

		def normal?

			@file_stat.normal?

		end # normal?

		def temporary?

			@file_stat.temporary?

		end # temporary?

		def compressed?

			@file_stat.compressed?

		end # compressed?

		def encrypted?

			@file_stat.encrypted?

		end # encrypted?

	end



		# indicates whether the given entry represents a directory
		def directory?

			@file_stat.directory?

		end # directory?

		# indicates whether the given entry represents a file
		def file?

			@file_stat.file?

		end # file?

		# indicates whether the given entry represents a link
		def link?

			@file_stat.link?

		end # link?

		# indicates whether the given entry represents a socket
		def socket?

			@file_stat.socket?

		end # socket?

		# ##########################
		# Size attributes

		# indicates the size of the given entry
		def size

			@file_stat.size

		end # size

		# ##########################
		# Time attributes

		# indicates the last access time of the entry
		def last_access_time

			@file_stat.atime

		end # last_access_time

		# indicates the modification time of the entry
		def modification_time

			@file_stat.mtime

		end # modification_time

		# ##########################
		# Comparison

	if Recls::Ximpl::OS::OS_IS_WINDOWS

		def <=>(rhs)

			path.upcase <=> rhs.path.upcase

		end # def <=>(rhs)

	else

		def <=>(rhs)

			path <=> rhs.path

		end # def <=>(rhs)

	end

		# ##########################
		# Conversion

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

# ############################## end of file ############################# #
