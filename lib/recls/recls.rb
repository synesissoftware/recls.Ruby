# ######################################################################### #
# File:         recls/recls.rb
#
# Purpose:      Main source file for recls library
#
# Created:      19th July 2012
# Updated:      29th December 2015
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


require 'recls/version'

require 'recls/filesearch'
require 'recls/foreach'
require 'recls/stat'
require 'recls/util'
require 'recls/ximpl/os'

module Recls

	# Represents the "all" wildcards string for the ambient operating
	# system
	WILDCARDS_ALL = Recls::Ximpl::OS::WILDCARDS_ALL

	PATH_NAME_SEPARATOR = Recls::Ximpl::OS::PATH_NAME_SEPARATOR

	PATH_SEPARATOR = Recls::Ximpl::OS::PATH_SEPARATOR
end

# ######################################################################### #
# Obsolete symbols

if not defined? RECLS_NO_OBSOLETE

	module Recls

		def self.pathNameSeparator
			PATH_NAME_SEPARATOR
		end

		def self.pathSeparator
			PATH_SEPARATOR
		end

		def self.wildcardsAll
			WILDCARDS_ALL
		end

		class FileSearch

			alias_method :searchRoot, :search_root
			alias_method :pattern, :patterns
		end

		class Entry

			alias_method :uncDrive, :drive
			alias_method :directoryPath, :directory_path
			alias_method :directoryParts, :directory_parts
			alias_method :file, :file_full_name
			alias_method :shortFile, :file_short_name
			alias_method :fileBaseName, :file_name_only
			alias_method :fileName, :file_name_only
			alias_method :fileExt, :file_extension
			alias_method :searchDirectory, :search_directory
			alias_method :searchRelativePath, :search_relative_path

			alias_method :isDirectory, :directory?
			alias_method :isFile, :file?
			#alias_method :isLink, :link?
			alias_method :isReadOnly, :readonly?
			def isUNC

				d = drive

				d and d.size > 2
			end

			alias_method :creationTime, :modification_time
		end
	end
end

# ############################## end of file ############################# #

