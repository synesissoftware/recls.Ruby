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
		# fileStat, and searchDir
		def initialize(path, fileStat, searchDir)

			@fileStat = fileStat

			@path = File::absolute_path path
			@directoryPath = File::dirname @path
			@directory = Recls::Ximpl::directoryFromDirectoryPath @directoryPath
			@directoryParts = Recls::Ximpl::directoryPartsFromDirectory directory

			@fileBasename = Recls::Ximpl::basename @path
			@fileExt = Recls::Ximpl::fileExt @fileBasename

			@searchDirectory = searchDir
			@searchRelativePath = Recls::Ximpl::searchRelativePath @path, searchDir

		end # def initialize

		attr_reader :path
		attr_reader :directoryPath
		attr_reader :directory
		attr_reader :directoryParts
		attr_reader :fileBasename
		alias_method :file, :fileBasename
		alias_method :fileName, :fileBasename
		attr_reader :fileExt
		attr_reader :searchDirectory
		attr_reader :searchRelativePath

		# indicates whether the given entry represents a directory
		def directory?

			@fileStat.directory?

		end # directory?

		# indicates whether the given entry represents a file
		def file?

			@fileStat.file?

		end # file?

		# indicates whether the given entry is readonly
		def readonly?

			not @fileStat.writable?

		end # readonly?

		# indicates whether the given entry represents a socket
		def socket?

			@fileStat.socket?

		end # socket?

		# indicates the size of the given entry
		def size

			@fileStat.size

		end # size

		# indicates the last access time of the entry
		def lastAccessTime

			@fileStat.atime

		end # lastAccessTime

		# indicates the modification time of the entry
		def modificationTime

			@fileStat.mtime

		end # modificationTime

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
