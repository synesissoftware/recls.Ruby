# ######################################################################### #
# File:         recls/entry.rb
#
# Purpose:      Defines the Recls::Entry class for the recls.Ruby library.
#
# Created:      24th July 2012
# Updated:      28th December 2015
#
# Author:       Matthew Wilson
#
# Copyright (c) 2012-2015, Matthew Wilson and Synesis Software
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# * Redistributions of source code must retain the above copyright notice,
#   this list of conditions and the following disclaimer.
#
# * Redistributions in binary form must reproduce the above copyright notice,
#   this list of conditions and the following disclaimer in the documentation
#   and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
#
# ######################################################################### #


require 'recls/ximpl/os'
require 'recls/ximpl/' + (Recls::Ximpl::OS::OS_IS_WINDOWS ? 'windows' : 'unix')
require 'recls/ximpl/util'
require 'recls/flags'

module Recls

	class Entry

		private
		def self.get_compare_path_(path)
			return path.upcase if Recls::Ximpl::OS::OS_IS_WINDOWS
			path
		end
		public

		# initialises an entry instance from the given path,
		# file_stat, and search_dir
		def initialize(path, file_stat, search_dir, flags)

			@file_stat		=	file_stat

			@path			=	Recls::Ximpl.absolute_path path
			@short_path		=	nil
			@compare_path	=	Entry.get_compare_path_ @path
			@hash			=	@compare_path.hash

			windows_drive, directory, basename, file_name, file_ext = Recls::Ximpl::Util.split_path @path

			@drive = windows_drive
			@directory_path = "#{windows_drive}#{directory}"
			@directory = directory ? directory : ''
			@directory_parts = Recls::Ximpl.directory_parts_from_directory directory
			@file_full_name = basename ? basename : ''
			@file_short_name = nil
			@file_name_only = file_name ? file_name : ''
			@file_extension = file_ext ? file_ext : ''

			@search_directory = search_dir
			@search_relative_path = Recls::Ximpl.derive_relative_path search_dir, @path
			@search_relative_directory_path = Recls::Ximpl.derive_relative_path search_dir, @directory_path
			@search_relative_directory = @search_relative_directory_path
			@search_relative_directory_parts = Recls::Ximpl.directory_parts_from_directory @search_relative_directory

			if 0 != (Recls::MARK_DIRECTORIES & flags) && directory?
				@path					=	Recls::Ximpl::Util.append_trailing_slash @path
				@search_relative_path	=	Recls::Ximpl::Util.append_trailing_slash @search_relative_path
			end

			@dev	=	@file_stat.dev if @file_stat
			@ino	=	@file_stat.ino if @file_stat
			@nlink	=	@file_stat.nlink if @file_stat

			if Recls::Ximpl::OS::OS_IS_WINDOWS && @file_stat
				@dev				=	@file_stat.by_handle_information.volume_id
				@ino				=	@file_stat.by_handle_information.file_index
				@nlink				=	@file_stat.by_handle_information.num_links
				@short_path			=	@file_stat.short_path
				@file_short_name	=	Recls::Ximpl::Util.split_path(@short_path)[2]
			else
			end
		end

		# ##########################
		# Name-related attributes

		attr_reader :compare_path

		attr_reader :path
		attr_reader :short_path
		attr_reader :drive
		attr_reader :directory_path
		alias_method :dirname, :directory_path
		attr_reader :directory
		attr_reader :directory_parts
		attr_reader :file_full_name
		attr_reader :file_short_name
		alias_method :basename, :file_full_name
		attr_reader :file_name_only
		alias_method :stem, :file_name_only
		attr_reader :file_extension
		alias_method :extension, :file_extension
		attr_reader :search_directory
		attr_reader :search_relative_path
		attr_reader :search_relative_directory
		attr_reader :search_relative_directory_path
		attr_reader :search_relative_directory_parts

		# ##########################
		# Nature attributes

		# indicates whether the given entry existed at the time the entry
		# instance was created
		def exist?

			not @file_stat.nil?
		end

		# indicates whether the given entry is hidden
		def hidden?

			@file_stat.hidden?
		end

		# indicates whether the given entry is readonly
		def readonly?

			not @file_stat.writable?
		end

		# ##########################
		# Comparison

	if Recls::Ximpl::OS::OS_IS_WINDOWS

		def system?

			@file_stat.system?
		end

		def archive?

			@file_stat.archive?
		end

		def device?

			@file_stat.device?
		end

		def normal?

			@file_stat.normal?
		end

		def temporary?

			@file_stat.temporary?
		end

		def compressed?

			@file_stat.compressed?
		end

		def encrypted?

			@file_stat.encrypted?
		end
	end

		# indicates whether the given entry represents a directory
		def directory?

			@file_stat.directory?
		end

		# indicates whether the given entry represents a file
		def file?

			@file_stat.file?
		end

		# indicates whether the given entry represents a link
		def link?

			@file_stat.link?
		end

		# indicates whether the given entry represents a socket
		def socket?

			@file_stat.socket?
		end

		# ##########################
		# Size attributes

		# indicates the size of the given entry
		def size

			@file_stat.size
		end

		# ##########################
		# File-system entry attributes

		# indicates the device of the given entry
		#
		# On Windows, this will be 0 if the entry cannot be
		# opened
		def dev

			@dev
		end

		# indicates the ino of the given entry
		#
		# On Windows, this will be 0 if the entry cannot be
		# opened
		def ino

			@ino
		end

		# number of links to the given entry
		#
		# On Windows, this will be 0 if the entry cannot be
		# opened
		def nlink

			@nlink
		end

		# ##########################
		# Time attributes

		# indicates the last access time of the entry
		def last_access_time

			@file_stat.atime
		end

		# indicates the modification time of the entry
		def modification_time

			@file_stat.mtime
		end

		# ##########################
		# Comparison

		# determines whether rhs is an instance of Entry and
		# refers to the same path
		def eql?(rhs)

			case	rhs
			when	self.class
				return compare_path == rhs.compare_path
			else
				return false
			end
		end

		# determines whether rhs refers to the same path
		def ==(rhs)

			case	rhs
			when	String
				return compare_path == Entry.get_compare_path_(rhs)
			when	self.class
				return compare_path == rhs.compare_path
			else
				return false
			end
		end

		# compares this instance with rhs
		def <=>(rhs)

			compare_path <=> rhs.compare_path
		end

		# the hash
		def hash

			@hash
		end

		# ##########################
		# Conversion

		# represents the entry as a string (in the form of
		# the full path)
		def to_s

			path
		end

		# represents the entry as a string (in the form of
		# the full path)
		def to_str

			path
		end
	end
end

# ############################## end of file ############################# #

