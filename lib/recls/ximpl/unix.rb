# ######################################################################### #
# File:        recls/ximpl/unix.rb
#
# Purpose:     UNIX-specific constructs for the recls library.
#
# Created:     19th February 2014
# Updated:     18th June 2015
#
# Author:      Matthew Wilson
#
# Copyright:   <<TBD>>
#
# ######################################################################### #


require 'recls/ximpl/util'

module Recls

	module Ximpl

		class FileStat < File::Stat

			private
			def initialize(path)

				@path = path

				super(path)
			end

			public
			attr_reader :path

			def hidden?

				basename = File.basename @path

				return false if basename.empty?
				return false if '.' == basename
				return false if '..' == basename
				return false if ?. != basename[0]

				return true
			end

			public
			def FileStat.stat(path)

				Recls::Ximpl::FileStat.new(path)

			end
		end
	end
end

# ############################## end of file ############################# #

