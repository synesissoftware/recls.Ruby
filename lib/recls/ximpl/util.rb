# ######################################################################### #
# File:        recls/ximpl/util.rb
#
# Purpose:     Internal implementation constructs for the recls library.
#
# Created:     24th July 2012
# Updated:     16th February 2014
#
# Author:      Matthew Wilson
#
# Copyright:   <<TBD>>
#
# ######################################################################### #

require File.dirname(__FILE__) + '/os'

module Recls

	module Ximpl

		def Ximpl.absolute_path(p)

			File::absolute_path p

		end # def Ximpl.absolute_path

		# obtains the basename of a path, e.g.
		# the basename of
		#  abc/def/ghi.jkl
		# or (on Windows)
		#  C:\abc\def\ghi.jkl
		# is
		#  ghi.jkl
		#
		def Ximpl.basename(path)

			if not path.is_a? String
				path = path.to_s
			end

			if path =~ /^.*[\/\\](.*)/
				$1
			else
				path
			end

		end # Ximpl.basename

		# obtains the file extension of a basename, e.g.
		# the file_ext of
		#  ghi.jkl
		# is
		#  .jkl
		def Ximpl.file_ext(file_basename)

			if file_basename =~ /^.*(\.[^.]*)$/
				$1
			else
				''
			end

		end # Ximpl.file_ext

		# obtains the directory from the directory path
		#
		def Ximpl.directory_from_directory_path(directory_path)

			if directory_path =~ /^[a-zA-Z]:([\\\/].*)/
				directory = $1
			elsif directory_path =~ /^\\\\[^\\\/:*?<>|]+\\[^\\\/:*?<>|]+/
				directory = $'
			else
				directory = directory_path
			end

			directory

		end # Ximpl.directory_from_directory_path

		# obtains the directory parts from a directory
		def Ximpl.directory_parts_from_directory(directory)

			directory_parts = []
			until directory.empty?
				if directory =~ /^([\\\/][^\\\/]+)/
					directory_parts << $1
					directory = $'
				else
					directory_parts << directory
					directory = ''
				end
			end
			directory_parts

		end # Ximpl.directory_parts_from_directory

		# obtains the search_relative_path from a path and
		# a search_directory
		def Ximpl.search_relative_path(path, search_directory)

			if search_directory and not search_directory.empty?

				if path =~ /^#{search_directory}[\\\/]/
					$'
				else
					path
				end
			else
				path
			end

		end # Ximpl.search_relative_path

	end # module Ximpl

end # module Recls
