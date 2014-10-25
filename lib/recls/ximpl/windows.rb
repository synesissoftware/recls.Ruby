# ######################################################################### #
# File:        recls/ximpl/windows.rb
#
# Purpose:     Windows-specific constructs for the recls library.
#
# Created:     19th February 2014
# Updated:     12th October 2014
#
# Author:      Matthew Wilson
#
# Copyright:   <<TBD>>
#
# ######################################################################### #


require 'Win32API'

module Recls

	module Ximpl

		class FileStat < File::Stat

			private
			GetFileAttributes = Win32API.new("kernel32", "GetFileAttributes", "P", "I")
			FILE_ATTRIBUTE_READONLY_	=	0x00000001
			FILE_ATTRIBUTE_HIDDEN_		=	0x00000002
			FILE_ATTRIBUTE_SYSTEM_		=	0x00000004
			FILE_ATTRIBUTE_DIRECTORY_	=	0x00000010
			FILE_ATTRIBUTE_ARCHIVE_		=	0x00000020
			FILE_ATTRIBUTE_DEVICE_		=	0x00000040
			FILE_ATTRIBUTE_NORMAL_		=	0x00000080
			FILE_ATTRIBUTE_TEMPORARY_	=	0x00000100
			FILE_ATTRIBUTE_COMPRESSED_	=	0x00000800
			FILE_ATTRIBUTE_ENCRYPTED_	=	0x00004000

			private
			def has_attribute_? (attr)

				0 != (attr & @attributes)

			end # def has_attribute_? (attr)

			private
			def initialize(path)

				@path = path

				# for some reason not forcing this new string cause 'can't modify frozen string (TypeError)'
				attributes = GetFileAttributes.call("#{path}")

				if 0xffffffff == attributes
					@attributes = 0
				else
					@attributes = attributes
				end

				super(path)

			end

			public
			attr_reader :attributes
			attr_reader :path

			def hidden?

				0 != (FILE_ATTRIBUTE_HIDDEN_ & @attributes)

			end # hidden?

			# Windows-specific attributes

			def system?

				has_attribute_? FILE_ATTRIBUTE_SYSTEM_

			end # system?

			def archive?

				has_attribute_? FILE_ATTRIBUTE_ARCHIVE_

			end # archive?

			def device?

				has_attribute_? FILE_ATTRIBUTE_DEVICE_

			end # device?

			def normal?

				has_attribute_? FILE_ATTRIBUTE_NORMAL_

			end # normal?

			def temporary?

				has_attribute_? FILE_ATTRIBUTE_TEMPORARY_

			end # temporary?

			def compressed?

				has_attribute_? FILE_ATTRIBUTE_COMPRESSED_

			end # compressed?

			def encrypted?

				has_attribute_? FILE_ATTRIBUTE_ENCRYPTED_

			end # encrypted?


			public
			def FileStat.stat(path)

				Recls::Ximpl::FileStat.new(path)

			end # def FileStat.stat(path)

		end

	end # module Ximpl

end # module Recls

# ############################## end of file ############################# #

