# ######################################################################### #
# File:        recls/ximpl/
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

#require File.dirname(__FILE__) + '/ximpl/os'

module Recls

	module Ximpl

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

		def Ximpl.fileExt(fileBasename)

			if fileBasename =~ /^.*(\.[^.]*)$/
				$1
			else
				''
			end

		end # Ximpl.fileExt

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

