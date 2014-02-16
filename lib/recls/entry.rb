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

		def initialize(path, fileStat, searchDir)

			@fileStat = fileStat

			@path = File::absolute_path path
			@directoryPath = File::dirname @path
			@directory = Ximpl::directoryFromDirectoryPath @directoryPath
			@directoryParts = Ximpl.directoryPartsFromDirectory directory

			@fileBasename = Recls::Ximpl::basename @path
			@fileExt = Recls::Ximpl::fileExt @fileBasename

			@searchDirectory = searchDir
			@searchRelativePath = Ximpl::searchRelativePath @path, searchDir

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

		def directory?

			@fileStat.directory?

		end # directory?

		def file?

			@fileStat.file?

		end # file?

		def readonly?

			not @fileStat.writable?

		end # readonly?

		def socket?

			@fileStat.socket?

		end # socket?

		def size

			@fileStat.size

		end # size

		def lastAccessTime

			@fileStat.atime

		end # lastAccessTime

		def modificationTime

			@fileStat.mtime

		end # modificationTime

		def to_s

			path

		end # def to_s

		def to_str

			path

		end # def to_s


	end # class Entry

end # module Recls

