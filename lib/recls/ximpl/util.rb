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
		# the fileExt of
		#  ghi.jkl
		# is
		#  .jkl
		def Ximpl.fileExt(fileBasename)

			if fileBasename =~ /^.*(\.[^.]*)$/
				$1
			else
				''
			end

		end # Ximpl.fileExt

		# obtains the directory from the directory path
		#
		def Ximpl.directoryFromDirectoryPath(directoryPath)

			if directoryPath =~ /^[a-zA-Z]:([\\\/].*)/
				directory = $1
			elsif directoryPath =~ /^\\\\[^\\\/:*?<>|]+\\[^\\\/:*?<>|]+/
				directory = $'
			else
				directory = directoryPath
			end

			directory

		end # Ximpl.directoryFromDirectoryPath

		# obtains the directory parts from a directory
		def Ximpl.directoryPartsFromDirectory(directory)

			directoryParts = []
			until directory.empty?
				if directory =~ /^([\\\/][^\\\/]+)/
					directoryParts << $1
					directory = $'
				else
					directoryParts << directory
					directory = ''
				end
			end
			directoryParts

		end # Ximpl.directoryPartsFromDirectory

		# obtains the searchRelativePath from a path and
		# a searchDirectory
		def Ximpl.searchRelativePath(path, searchDirectory)

			if searchDirectory and not searchDirectory.empty?

				if path =~ /^#{searchDirectory}[\\\/]/
					$'
				else
					path
				end
			else
				path
			end

		end # Ximpl.searchRelativePath

	end # module Ximpl

end # module Recls