# ######################################################################### #
# File:         recls/recls.rb
#
# Purpose:      Main source file for recls library
#
# Created:      19th July 2012
# Updated:      3rd July 2015
#
# Author:       Matthew Wilson
#
# Copyright:	<<TBD>>
#
# ######################################################################### #


require 'recls/internal/common'
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

