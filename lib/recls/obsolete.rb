# ######################################################################### #
# File:         recls/obsolete.rb
#
# Purpose:      Obsolete elements
#
# Created:      19th July 2012
# Updated:      14th April 2019
#
# Author:       Matthew Wilson
#
# Copyright (c) 2012-2019, Matthew Wilson and Synesis Software
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



# ######################################################################### #
# Obsolete symbols

if not defined? RECLS_NO_OBSOLETE

	module Recls # :nodoc: all

		# @!visibility private
		def self.pathNameSeparator

			PATH_NAME_SEPARATOR
		end

		# @!visibility private
		def self.pathSeparator

			PATH_SEPARATOR
		end

		# @!visibility private
		def self.wildcardsAll

			WILDCARDS_ALL
		end

		class FileSearch # :nodoc:

			# @!visibility private
			alias_method :searchRoot, :search_root
			# @!visibility private
			alias_method :pattern, :patterns
		end

		class Entry # :nodoc:

			# @!visibility private
			alias_method :uncDrive, :drive
			# @!visibility private
			alias_method :directoryPath, :directory_path
			# @!visibility private
			alias_method :directoryParts, :directory_parts
			# @!visibility private
			alias_method :file, :file_full_name
			# @!visibility private
			alias_method :shortFile, :file_short_name
			# @!visibility private
			alias_method :fileBaseName, :file_name_only
			# @!visibility private
			alias_method :fileName, :file_name_only
			# @!visibility private
			alias_method :fileExt, :file_extension
			# @!visibility private
			alias_method :searchDirectory, :search_directory
			# @!visibility private
			alias_method :searchRelativePath, :search_relative_path

			# @!visibility private
			alias_method :isDirectory, :directory?
			# @!visibility private
			alias_method :isFile, :file?
			#alias_method :isLink, :link?
			# @!visibility private
			alias_method :isReadOnly, :readonly?
			# @!visibility private
			def isUNC

				d = drive

				d and d.size > 2
			end

			# @!visibility private
			alias_method :creationTime, :modification_time
		end
	end # module Recls
end

# ############################## end of file ############################# #


